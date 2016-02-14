public class PolarWallwiseGeometryGenerator : GeometryGenerator {
  let grid: Grid
  let layout: PolarLayout
  let scale: CGFloat
  let margin: CGFloat

  public let bounds: CGRect

  public required init(grid: Grid, scale: CGFloat, margin: CGFloat) {
    self.grid = grid
    self.scale = scale
    self.layout = grid.layout as! PolarLayout
    self.margin = margin
    self.bounds = CGRect(x: 0, y: 0,
      width: CGFloat(layout.rings * 2) * scale + margin*2,
      height: CGFloat(layout.rings * 2) * scale + margin*2)
  }

  public func render(ctx: CGContextRef) {
    UIColor.blackColor().setStroke()
    UIColor.whiteColor().setFill()

    CGContextFillRect(ctx, bounds)

    CGContextSetLineCap(ctx, CGLineCap.Round)
    CGContextSetLineWidth(ctx, 1.0)

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
          CGContextMoveToPoint(ctx, bx, by)
          CGContextAddArc(ctx, ox, oy, outerRadius, thetaCCW, thetaCW, 0)
        }

        if !cell.isLinkedWith(cell.inward) {
          CGContextMoveToPoint(ctx, ax, ay)
          CGContextAddArc(ctx, ox, oy, innerRadius, thetaCCW, thetaCW, 0)
        }

        if !cell.isLinkedWith(cell.ccw) && cell != cell.ccw {
          //CGContextMoveToPoint(ctx, ax, ay)
          //CGContextAddLineToPoint(ctx, bx, by)
        }
      }
    }
    
    CGContextStrokePath(ctx)
  }
}