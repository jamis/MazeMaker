open class PolarWallwiseGeometryGenerator : GeometryGenerator {
  let grid: Grid
  let layout: PolarLayout
  let scale: CGFloat
  let margin: CGFloat

  open let bounds: CGRect

  public required init(grid: Grid, scale: CGFloat, margin: CGFloat) {
    self.grid = grid
    self.scale = scale
    self.layout = grid.layout as! PolarLayout
    self.margin = margin
    self.bounds = CGRect(x: 0, y: 0,
      width: CGFloat(layout.rings * 2) * scale + margin*2,
      height: CGFloat(layout.rings * 2) * scale + margin*2)
  }

  open func render(_ ctx: CGContext) {
    UIColor.black.setStroke()
    UIColor.white.setFill()

    ctx.fill(bounds)

    ctx.setLineCap(CGLineCap.round)
    ctx.setLineWidth(1.0)

    let ox = bounds.size.width / 2
    let oy = bounds.size.height / 2

    for cell in grid.cells {
      if let cell = cell as? PolarCell {
        let theta = CGFloat(2 * M_PI) / CGFloat(layout.ringSizeAt(cell.polarLocation.ring))
        let innerRadius = CGFloat(cell.polarLocation.ring) * scale
        let outerRadius = CGFloat(cell.polarLocation.ring+1) * scale
        let thetaCCW = CGFloat(cell.polarLocation.spoke) * theta
        let thetaCW = CGFloat(cell.polarLocation.spoke+1) * theta

        let ax = ox + innerRadius * cos(thetaCCW)
        let ay = oy + innerRadius * sin(thetaCCW)
        let bx = ox + outerRadius * cos(thetaCCW)
        let by = oy + outerRadius * sin(thetaCCW)

        if cell.outward.isEmpty {
          ctx.move(to: CGPoint(x: bx, y: by))
            ctx.addArc(center: CGPoint(x: ox, y: oy), radius: outerRadius, startAngle: thetaCCW, endAngle: thetaCW, clockwise: false)
        }

        if !cell.isLinkedWith(cell.inward) {
          ctx.move(to: CGPoint(x: ax, y: ay))
            ctx.addArc(center: CGPoint(x: ox, y: oy), radius: innerRadius, startAngle: thetaCCW, endAngle: thetaCW, clockwise: false)
        }

        if !cell.isLinkedWith(cell.ccw) && cell != cell.ccw {
          //CGContextMoveToPoint(ctx, ax, ay)
          //CGContextAddLineToPoint(ctx, bx, by)
        }
      }
    }
    
    ctx.strokePath()
  }
}
