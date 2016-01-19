public class OrthogonalCell: Cell {
  public var gridLocation: GridLocation {
    return location as! GridLocation
  }

  public var north: OrthogonalCell? = nil
  public var south: OrthogonalCell? = nil
  public var east: OrthogonalCell? = nil
  public var west: OrthogonalCell? = nil

  public override var neighbors: Set<Cell> {
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