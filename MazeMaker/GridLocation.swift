public class GridLocation: Location {
  public let row: Int
  public let column: Int

  public override var hashValue: Int {
    return row * 1000 + column
  }

  public init(row: Int, column: Int) {
    self.row = row
    self.column = column
  }

  public func change(rowBy row: Int = 0, columnBy column: Int = 0) -> GridLocation {
    return GridLocation(row: self.row + row, column: self.column + column);
  }

  public override func isEqual(location: Location) -> Bool {
    if let location = location as? GridLocation {
      return (row == location.row) && (column == location.column)
    } else {
      return false
    }
  }
}