import Foundation

public class PolarLayout: Layout {
  public let rings: Int
  private var ringSizes: Array<Int> = []

  public init(rings: Int) {
    self.rings = rings

    let ringHeight = 1.0 / Double(rings)

    ringSizes.append(1)
    for ring in 1..<rings {
      let radius = Double(ring) / Double(rings)
      let circumference = 2 * M_PI * radius
      let priorCount = ringSizes[ring-1]
      let estimatedCellWidth = circumference / Double(priorCount)
      let ratio = Int(round(estimatedCellWidth / ringHeight))
      ringSizes.append(priorCount * ratio)
    }
  }

  public func build(grid: Grid) {
    for (ring, count) in ringSizes.enumerate() {
      for spoke in 0..<count {
        let location = PolarLocation(ring: ring, spoke: spoke)
        let cell = PolarCell(location: location)
        grid.add(cell)

        if ring > 0 {
          let ratio = ringSizes[ring] / ringSizes[ring-1]
          let inwardLocation = PolarLocation(ring: ring-1, spoke: spoke / ratio)
          let inwardCell = grid.at(inwardLocation) as! PolarCell

          cell.inward = inwardCell
          inwardCell.outward.append(cell)
        }

        if spoke > 0 {
          let ccwLocation = location.change(spokeBy: -1)
          let ccwCell = grid.at(ccwLocation) as! PolarCell
          cell.ccw = ccwCell
          ccwCell.cw = cell
        }

        if spoke+1 == count {
          let cwCell = grid.at(PolarLocation(ring: ring, spoke: 0)) as! PolarCell
          cell.cw = cwCell
          cwCell.ccw = cell
        }
      }
    }
  }

  public func ringSizeAt(ring: Int) -> Int {
    return ringSizes[ring];
  }

  public func renderAsString(grid: Grid) -> String {
    fatalError("polar layouts cannot be rendered as a string")
  }
}