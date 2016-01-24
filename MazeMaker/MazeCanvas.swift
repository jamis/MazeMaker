import Foundation
import UIKit

public class MazeCanvas: UIView {
  let grid: Grid
  let scale: CGFloat
  let margin: CGFloat = 10.0

  public init(grid: Grid, scale: CGFloat) {
    self.grid = grid
    self.scale = scale

    var size = grid.layout.dimensionsWithScale(Double(scale))
    size = CGSize(width: size.width + margin*2, height: size.height + margin*2)

    super.init(frame: CGRect(origin: CGPoint.zero, size: size))
  }

  required public init?(coder aDecoder: NSCoder) {
    self.scale = CGFloat(aDecoder.decodeDoubleForKey("scale"))
    self.grid = aDecoder.decodeObjectForKey("grid") as! Grid
    super.init(coder: aDecoder)
  }

  override public func drawRect(rect: CGRect) {
    let ctx = UIGraphicsGetCurrentContext()

    UIColor.blackColor().setStroke()
    UIColor.whiteColor().setFill()

    CGContextFillRect(ctx, rect)

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