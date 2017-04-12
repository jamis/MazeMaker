open class Location: Hashable {
  open var hashValue: Int { return 0 }
  open func isEqual(_ location: Location) -> Bool {
    return hashValue == location.hashValue
  }
}

public func ==(lhs: Location, rhs: Location) -> Bool {
  return lhs.isEqual(rhs)
}
