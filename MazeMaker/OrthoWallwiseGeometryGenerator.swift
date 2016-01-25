public class OrthoWallwiseGeometryGenerator : GeometryGenerator {
  let grid: Grid
  let layout: OrthogonalLayout
  let scale: CGFloat
  let margin: CGFloat

  public let bounds: CGRect

  public required init(grid: Grid, scale: CGFloat, margin: CGFloat) {
    self.grid = grid
    self.scale = scale
    self.layout = grid.layout as! OrthogonalLayout
    self.margin = margin
    self.bounds = CGRect(x: 0, y: 0,
      width: CGFloat(layout.columns) * scale + margin*2,
      height: CGFloat(layout.rows) * scale + margin*2)
  }

  public func render(ctx: CGContextRef) {
    UIColor.blackColor().setStroke()
    UIColor.whiteColor().setFill()

    CGContextFillRect(ctx, bounds)

    CGContextSetLineCap(ctx, CGLineCap.Round)
    CGContextSetLineWidth(ctx, 1.0)

    for cell in grid.cells {
      if let cell = cell as? OrthogonalCell {
        let x = CGFloat(cell.gridLocation.column) * scale + margin
        let y = CGFloat(cell.gridLocation.row) * scale + margin

        let x2 = CGFloat(cell.gridLocation.column+1) * scale + margin
        let y2 = CGFloat(cell.gridLocation.row+1) * scale + margin

        if cell.north == nil {
          CGContextMoveToPoint(ctx, x, y)
          CGContextAddLineToPoint(ctx, x2, y)
        }

        if cell.west == nil {
          CGContextMoveToPoint(ctx, x, y)
          CGContextAddLineToPoint(ctx, x, y2)
        }

        if !cell.isLinkedWith(cell.south) {
          CGContextMoveToPoint(ctx, x, y2)
          CGContextAddLineToPoint(ctx, x2, y2)
        }

        if !cell.isLinkedWith(cell.east) {
          CGContextMoveToPoint(ctx, x2, y)
          CGContextAddLineToPoint(ctx, x2, y2)
        }
      }
    }
    
    CGContextStrokePath(ctx)
  }
}