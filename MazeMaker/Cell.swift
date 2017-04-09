open class Cell: Hashable {
  fileprivate(set) var links : Set<Cell> = []
  open fileprivate(set) var location : Location

  open var hashValue: Int {
    return location.hashValue
  }

  open var neighbors: Set<Cell> {
    preconditionFailure("neighbors must be overridden in subclasses");
  }

  public init(location: Location) {
    self.location = location
  }

  func linkOnceWith(_ neighbor: Cell) {
    links.insert(neighbor)
  }

  func unlinkOnceFrom(_ neighbor: Cell) {
    links.remove(neighbor)
  }

  open func linkWith(_ neighbor: Cell) {
    linkOnceWith(neighbor)
    neighbor.linkOnceWith(self)
  }

  open func unlinkFrom(_ neighbor: Cell) {
    unlinkOnceFrom(neighbor)
    neighbor.unlinkOnceFrom(self)
  }

  open func isLinkedWith(_ neighbor: Cell?) -> Bool {
    if let neighbor = neighbor {
      return links.contains(neighbor)
    } else {
      return false
    }
  }

  open func isDeadEnd() -> Bool {
    return links.count == 1
  }

  open func reset() {
    links.removeAll()
  }
}

public func ==(lhs: Cell, rhs: Cell) -> Bool {
  return lhs.location == rhs.location
}
