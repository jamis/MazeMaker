open class OrthoWallwiseGeometryGenerator : GeometryGenerator {
  let grid: Grid
  let layout: OrthogonalLayout
  let scale: CGFloat
  let margin: CGFloat

  open let bounds: CGRect

  public required init(grid: Grid, scale: CGFloat, margin: CGFloat) {
    self.grid = grid
    self.scale = scale
    self.layout = grid.layout as! OrthogonalLayout
    self.margin = margin
    self.bounds = CGRect(x: 0, y: 0,
      width: CGFloat(layout.columns) * scale + margin*2,
      height: CGFloat(layout.rows) * scale + margin*2)
  }

  open func render(_ ctx: CGContext) {
    UIColor.black.setStroke()
    UIColor.white.setFill()

    ctx.fill(bounds)

    ctx.setLineCap(CGLineCap.round)
    ctx.setLineWidth(1.0)

    for cell in grid.cells {
      if let cell = cell as? OrthogonalCell {
        let x = CGFloat(cell.gridLocation.column) * scale + margin
        let y = CGFloat(cell.gridLocation.row) * scale + margin

        let x2 = CGFloat(cell.gridLocation.column+1) * scale + margin
        let y2 = CGFloat(cell.gridLocation.row+1) * scale + margin

        if cell.north == nil {
          ctx.move(to: CGPoint(x: x, y: y))
          ctx.addLine(to: CGPoint(x: x2, y: y))
        }

        if cell.west == nil {
          ctx.move(to: CGPoint(x: x, y: y))
          ctx.addLine(to: CGPoint(x: x, y: y2))
        }

        if !cell.isLinkedWith(cell.south) {
          ctx.move(to: CGPoint(x: x, y: y2))
          ctx.addLine(to: CGPoint(x: x2, y: y2))
        }

        if !cell.isLinkedWith(cell.east) {
          ctx.move(to: CGPoint(x: x2, y: y))
          ctx.addLine(to: CGPoint(x: x2, y: y2))
        }
      }
    }
    
    ctx.strokePath()
  }
}
