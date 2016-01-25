public class PolarCell: Cell {
  public var polarLocation: PolarLocation {
    return location as! PolarLocation
  }

  public var outward: Array<PolarCell> = []
  public var inward: PolarCell? = nil
  public var cw: PolarCell? = nil
  public var ccw: PolarCell? = nil

  public override var neighbors: Set<Cell> {
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