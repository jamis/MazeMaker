import XCTest
@testable import MazeMaker

class GridLocationTests: XCTestCase {

  func testInitShouldConstructLocation() {
    let loc = GridLocation(row: 5, column: 10)
    XCTAssertEqual(loc.row, 5)
    XCTAssertEqual(loc.column, 10)
  }

  func testEqualityShouldMatchLocations() {
    let loc1 = GridLocation(row: 5, column: 10)
    let loc2 = GridLocation(row: 5, column: 10)
    let loc3 = GridLocation(row: 6, column: 10)
    let loc4 = GridLocation(row: 5, column: 11)

    XCTAssertEqual(loc1, loc2)
    XCTAssertNotEqual(loc1, loc3)
    XCTAssertNotEqual(loc1, loc4)
  }

  func testChangeByCanChangeRow() {
    let loc1 = GridLocation(row: 5, column: 10)
    let loc2 = loc1.change(rowBy: 2)
    XCTAssertEqual(loc1.row, 5)
    XCTAssertEqual(loc2.row, 7)
    XCTAssertEqual(loc2.column, 10)
  }

  func testChangeByCanChangeColumn() {
    let loc1 = GridLocation(row: 5, column: 10)
    let loc2 = loc1.change(columnBy: 2)
    XCTAssertEqual(loc1.column, 10)
    XCTAssertEqual(loc2.row, 5)
    XCTAssertEqual(loc2.column, 12)
  }

}
