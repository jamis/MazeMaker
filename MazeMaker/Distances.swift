open class Distances {
  open let root: Cell
  fileprivate var distances: [Cell: Int] = [:]

  fileprivate(set) open var farthestCell: Cell
  fileprivate(set) open var farthestDistance: Int

  public init(root: Cell) {
    self.root = root
    distances[root] = 0
    farthestCell = root
    farthestDistance = 0
  }

  open subscript(element: Cell) -> Int? {
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

  open func shortestPathToCell(_ cell: Cell) -> [Cell] {
    var current = cell
    var path = [cell]

    while current != root {
      let next = current.links.min { distances[$0] ?? 0 < distances[$1] ?? 0 }!
      path.append(next)
      current = next
    }

    return path.reversed()
  }
}
