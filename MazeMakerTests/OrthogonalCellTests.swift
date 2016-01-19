import XCTest
@testable import MazeMaker

class OrthogonalCellTests: XCTestCase {

  func testNorthShouldBeAccessor() {
    let cell = OrthogonalCell(location: GridLocation(row: 2, column: 1))
    let north = OrthogonalCell(location: cell.gridLocation.change(rowBy: -1))

    XCTAssertNil(cell.north)

    cell.north = north
    XCTAssertEqual(cell.north, north)
  }

  func testSouthShouldBeAccessor() {
    let cell = OrthogonalCell(location: GridLocation(row: 2, column: 2))
    let south = OrthogonalCell(location: cell.gridLocation.change(rowBy: 1))

    XCTAssertNil(cell.south)

    cell.south = south
    XCTAssertEqual(cell.south, south)
  }

  func testEastShouldBeAccessor() {
    let cell = OrthogonalCell(location: GridLocation(row: 2, column: 2))
    let east = OrthogonalCell(location: cell.gridLocation.change(columnBy: 1))

    XCTAssertNil(cell.east)

    cell.east = east
    XCTAssertEqual(cell.east, east)
  }

  func testWestShouldBeAccessor() {
    let cell = OrthogonalCell(location: GridLocation(row: 2, column: 2))
    let west = OrthogonalCell(location: cell.gridLocation.change(columnBy: -1))

    XCTAssertNil(cell.west)

    cell.west = west
    XCTAssertEqual(cell.west, west)
  }

  func testNeighborsShouldIncludeAllNonNilNeighbors() {
    let cell = OrthogonalCell(location: GridLocation(row: 2, column: 2))

    let north = OrthogonalCell(location: cell.gridLocation.change(rowBy: -1))
    let south = OrthogonalCell(location: cell.gridLocation.change(rowBy: 1))
    let west = OrthogonalCell(location: cell.gridLocation.change(columnBy: -1))
    let east = OrthogonalCell(location: cell.gridLocation.change(columnBy: 1))

    XCTAssert(cell.neighbors.isEmpty)

    cell.north = north
    XCTAssert(cell.neighbors.contains(north))
    XCTAssert(!cell.neighbors.contains(west))

    cell.west = west
    XCTAssert(cell.neighbors.contains(west))

    cell.south = south
    cell.east = east

    XCTAssertEqual(cell.neighbors.count, 4)
    XCTAssert(cell.neighbors.contains(south))
    XCTAssert(cell.neighbors.contains(east))
  }

}
