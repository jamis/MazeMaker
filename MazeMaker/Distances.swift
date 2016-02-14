public class Distances {
  public let root: Cell
  private var distances: [Cell: Int] = [:]

  private(set) public var farthestCell: Cell
  private(set) public var farthestDistance: Int

  public init(root: Cell) {
    self.root = root
    distances[root] = 0
    farthestCell = root
    farthestDistance = 0
  }

  public subscript(element: Cell) -> Int? {
    get {
      return distances[element]
    }

    set(newValue) {
      let newValue = newValue!
      distances[element] = newValue
      if newValue > farthestDistance {
        farthestCell = element
        farthestDistance = newValue
      }
    }
  }

  public func shortestPathToCell(cell: Cell) -> [Cell] {
    var current = cell
    var path = [cell]

    while current != root {
      let next = current.links.minElement { distances[$0] < distances[$1] }!
      path.append(next)
      current = next
    }

    return path.reverse()
  }
}