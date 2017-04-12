import Foundation
import UIKit

open class MazeCanvas: UIView {
  let generator: GeometryGenerator

  public init(geometry: GeometryGenerator) {
    self.generator = geometry
    super.init(frame: generator.bounds)
  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("decoder init must be defined")
  }

  override open func draw(_ rect: CGRect) {
    let ctx = UIGraphicsGetCurrentContext()!
    generator.render(ctx)
  }
}
