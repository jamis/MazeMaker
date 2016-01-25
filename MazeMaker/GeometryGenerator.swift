public protocol GeometryGenerator {
  var bounds: CGRect { get }

  init(grid: Grid, scale: CGFloat, margin: CGFloat)
  func render(ctx: CGContextRef)
}