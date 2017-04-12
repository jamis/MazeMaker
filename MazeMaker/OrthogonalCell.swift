open class OrthogonalCell: Cell {
  open var gridLocation: GridLocation {
    return location as! GridLocation
  }

  open var north: OrthogonalCell? = nil
  open var south: OrthogonalCell? = nil
  open var east: OrthogonalCell? = nil
  open var west: OrthogonalCell? = nil

  open override var neighbors: Set<Cell> {
    var neighbors: Set<Cell> = Set()
    if let north = north { neighbors.insert(north) }
    if let south = south { neighbors.insert(south) }
    if let east = east { neighbors.insert(east) }
    if let west = west { neighbors.insert(west) }
    return neighbors
  }

  public override init(location: Location) {
    super.init(location: location)
  }
}
