public class Grid {
  public private(set) var cells: Set<Cell> = Set<Cell>()
  private var slots: [Location : Cell] = [:]

  private(set) var layout: Layout

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

  public func toString() -> String {
    return layout.renderAsString(self)
  }
}