import Foundation

open class AldousBroder : Algorithm {
  public init() { }

  open func applyTo(_ grid: Grid) {
    var cell = grid.sample()
    var count = grid.cells.count - 1

    while count > 0 {
      let neighbor = cell.neighbors.sample()!

      if neighbor.links.isEmpty {
        cell.linkWith(neighbor)
        count -= 1
      }

      cell = neighbor
    }
  }
}
