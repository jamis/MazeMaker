public class Cell: Hashable {
  private(set) var links : Set<Cell> = []
  public private(set) var location : Location

  public var hashValue: Int {
    return location.hashValue
  }

  public var neighbors: Set<Cell> {
    preconditionFailure("neighbors must be overridden in subclasses");
  }

  public init(location: Location) {
    self.location = location
  }

  func linkOnceWith(neighbor: Cell) {
    links.insert(neighbor)
  }

  func unlinkOnceFrom(neighbor: Cell) {
    links.remove(neighbor)
  }

  public func linkWith(neighbor: Cell) {
    linkOnceWith(neighbor)
    neighbor.linkOnceWith(self)
  }

  public func unlinkFrom(neighbor: Cell) {
    unlinkOnceFrom(neighbor)
    neighbor.unlinkOnceFrom(self)
  }

  public func isLinkedWith(neighbor: Cell?) -> Bool {
    if let neighbor = neighbor {
      return links.contains(neighbor)
    } else {
      return false
    }
  }

  public func reset() {
    links.removeAll()
  }
}

public func ==(lhs: Cell, rhs: Cell) -> Bool {
  return lhs.location == rhs.location
}