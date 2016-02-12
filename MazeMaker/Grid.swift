public class Grid {
  public private(set) var cells: Set<Cell> = Set<Cell>()
  private var slots: [Location : Cell] = [:]

  public private(set) var layout: Layout

  public init(layout: Layout) {
    self.layout = layout
    layout.build(self)
  }

  public func add(cell: Cell) -> Self {
    cells.insert(cell)
    slots[cell.location] = cell
    return self
  }

  public func remove(cell: Cell) -> Self {
    cells.remove(cell)
    slots.removeValueForKey(cell.location)
    return self
  }

  public func at(location: Location) -> Cell? {
    return slots[location]
  }

  public func reset() -> Self {
    for cell in cells {
      cell.reset()
    }

    return self
  }

  public func sample() -> Cell {
    precondition(cells.count > 0, "cannot sample an empty grid")
    return cells.sample()!
  }

  public func braid(p: Float = 0.5) {
    let deadends = cells.filter { $0.isDeadEnd() }.shuffle()
    let count = Int(ceilf(Float(deadends.count) * p))

    for i in 0..<count {
      let cell = deadends[i]
      let neighbor = cell.neighbors.filter { !cell.isLinkedWith($0) }.sample()

      if let neighbor = neighbor {
        cell.linkWith(neighbor)
      }
    }
  }

  public func toString() -> String {
    return layout.renderAsString(self)
  }
}