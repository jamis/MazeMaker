public class OrthogonalLayout: Layout {
  public let rows: Int
  public let columns: Int

  public init(rows: Int, columns: Int) {
    self.rows = rows
    self.columns = columns
  }

  public func build(grid: Grid) {
    for row in 0..<rows {
      for column in 0..<columns {
        let location = GridLocation(row: row, column: column)
        let cell = OrthogonalCell(location: location)
        grid.add(cell)

        let north = GridLocation(row: row-1, column: column)
        if let north = grid.at(north) as? OrthogonalCell {
          cell.north = north
          north.south = cell
        }

        let west = GridLocation(row: row, column: column-1)
        if let west = grid.at(west) as? OrthogonalCell {
          cell.west = west
          west.east = cell
        }
      }
    }
  }

  public func renderAsString(grid: Grid) -> String {
    var string = ""

    for _ in 0..<columns {
      string += "+---"
    }
    string += "+\n"

    for row in 0..<rows {
      string += "|"
      var bottom = "+"

      for column in 0..<columns {
        let loc = GridLocation(row: row, column: column)
        let cell = grid.at(loc) as! OrthogonalCell

        string += "   "
        string += cell.isLinkedWith(cell.east) ? " " : "|"

        bottom += cell.isLinkedWith(cell.south) ? "   " : "---"
        bottom += "+"
      }

      string += "\n" + bottom + "\n"
    }

    return string
  }

  public func dimensionsWithScale(scale: Double) -> CGSize {
    return CGSize(width: scale * Double(columns), height: scale * Double(rows))
  }
}