public class OrthoLinewiseGeometryGenerator : GeometryGenerator {
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

    CGContextBeginPath(ctx)
    CGContextMoveToPoint(ctx, margin, margin)
    CGContextAddLineToPoint(ctx, self.bounds.size.width-margin, margin)
    CGContextMoveToPoint(ctx, margin, margin)
    CGContextAddLineToPoint(ctx, margin, self.bounds.size.height-margin)

    for cell in grid.cells {
      if let cell = cell as? OrthogonalCell {
        let x = CGFloat(cell.gridLocation.column) * scale
        let y = CGFloat(cell.gridLocation.row) * scale

        let x2 = CGFloat(cell.gridLocation.column+1) * scale
        let y2 = CGFloat(cell.gridLocation.row+1) * scale

        if !cell.isLinkedWith(cell.south) {
          CGContextMoveToPoint(ctx, margin + x, margin + y2)
          CGContextAddLineToPoint(ctx, margin + x2, margin + y2)
        }

        if !cell.isLinkedWith(cell.east) {
          CGContextMoveToPoint(ctx, margin + x2, margin + y)
          CGContextAddLineToPoint(ctx, margin + x2, margin + y2)
        }
      }
    }
    
    CGContextStrokePath(ctx)
  }
}