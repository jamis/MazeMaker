import Foundation

public class AldousBroder : Algorithm {
  public init() { }

  public func applyTo(grid: Grid) {
    var cell = grid.sample()
    var count = grid.cells.count - 1

    while count > 0 {
      let neighbor = cell.neighbors.sample()!

      if neighbor.links.isEmpty {
        cell.linkWith(neighbor)
        count--
      }

      cell = neighbor
    }
  }
}