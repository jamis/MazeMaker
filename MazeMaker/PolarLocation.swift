public class PolarLocation: Location {
  public let ring: Int
  public let spoke: Int

  public override var hashValue: Int {
    return ring * 1000 + spoke
  }

  public init(ring: Int, spoke: Int) {
    self.ring = ring
    self.spoke = spoke
  }

  public func change(ringBy ring: Int = 0, spokeBy spoke: Int = 0) -> PolarLocation {
    return PolarLocation(ring: self.ring + ring, spoke: self.spoke + spoke);
  }

  public override func isEqual(location: Location) -> Bool {
    if let location = location as? PolarLocation {
      return (ring == location.ring) && (spoke == location.spoke)
    } else {
      return false
    }
  }
}