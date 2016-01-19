public class Location: Hashable {
  public var hashValue: Int { return 0 }
  public func isEqual(location: Location) -> Bool {
    return hashValue == location.hashValue
  }
}

public func ==(lhs: Location, rhs: Location) -> Bool {
  return lhs.isEqual(rhs)
}