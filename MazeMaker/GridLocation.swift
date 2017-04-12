open class GridLocation: Location {
  open let row: Int
  open let column: Int

  open override var hashValue: Int {
    return row * 1000 + column
  }

  public init(row: Int, column: Int) {
    self.row = row
    self.column = column
  }

  open func change(rowBy row: Int = 0, columnBy column: Int = 0) -> GridLocation {
    return GridLocation(row: self.row + row, column: self.column + column);
  }

  open override func isEqual(_ location: Location) -> Bool {
    if let location = location as? GridLocation {
      return (row == location.row) && (column == location.column)
    } else {
      return false
    }
  }
}
