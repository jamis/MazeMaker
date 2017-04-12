public protocol Layout {
  func build(_ grid: Grid)
  func renderAsString(_ grid: Grid) -> String
}
