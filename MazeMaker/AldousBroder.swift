import Foundation

public class AldousBroder : Algorithm {
  public init(grid: Grid) {
    let _ = applyTo(grid)
  }

  public func applyTo(grid: Grid) -> Grid {
    var cell = grid.sample()
    var count = grid.cells.count - 1

    while count > 0 {
      let neighbors = cell.neighbors
      let offset = Int(arc4random_uniform(UInt32(neighbors.count)))
      let index = neighbors.startIndex.advancedBy(offset)
      let neighbor = neighbors[index]

      if neighbor.links.isEmpty {
        cell.linkWith(neighbor)
        count--
      }

      cell = neighbor
    }

    return grid;
  }
}