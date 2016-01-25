import Foundation
import UIKit

public class MazeCanvas: UIView {
  let generator: GeometryGenerator

  public init(geometry: GeometryGenerator) {
    self.generator = geometry
    super.init(frame: generator.bounds)
  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("decoder init must be defined")
  }

  override public func drawRect(rect: CGRect) {
    let ctx = UIGraphicsGetCurrentContext()!
    generator.render(ctx)
  }
}