public protocol Layout {
  func build(grid: Grid)
  func renderAsString(grid: Grid) -> String
  func dimensionsWithScale(scale: Double) -> CGSize
}