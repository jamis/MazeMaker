open class PolarCell: Cell {
  open var polarLocation: PolarLocation {
    return location as! PolarLocation
  }

  open var outward: Array<PolarCell> = []
  open var inward: PolarCell? = nil
  open var cw: PolarCell? = nil
  open var ccw: PolarCell? = nil

  open override var neighbors: Set<Cell> {
    var neighbors: Set<Cell> = Set(outward)
    if let inward = inward { neighbors.insert(inward) }
    if let cw = cw { neighbors.insert(cw) }
    if let ccw = ccw { neighbors.insert(ccw) }
    return neighbors
  }

  public override init(location: Location) {
    super.init(location: location)
  }
}
