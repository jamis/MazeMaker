import XCTest
@testable import MazeMaker

class CellTests: XCTestCase {

  func testInitShouldUseLocation() {
    let loc = TestLocation(position: 5)
    let cell = Cell(location: loc)
    XCTAssertEqual(cell.location, loc)
  }

  func testLinkWithShouldCreateBidirectionalRelationship() {
    let cell1 = Cell(location: TestLocation(position: 1))
    let cell2 = Cell(location: TestLocation(position: 2))

    XCTAssert(!cell1.isLinkedWith(cell2))
    XCTAssert(!cell2.isLinkedWith(cell1))

    cell1.linkWith(cell2)

    XCTAssertEqual(cell1.links, Set([cell2]))
    XCTAssertEqual(cell2.links, Set([cell1]))

    XCTAssert(cell1.isLinkedWith(cell2))
    XCTAssert(cell2.isLinkedWith(cell1))
  }

  func testUnlinkFromShouldRemoveBidirectionalRelationship() {
    let cell1 = Cell(location: TestLocation(position: 1))
    let cell2 = Cell(location: TestLocation(position: 2))
    cell1.linkWith(cell2)

    cell1.unlinkFrom(cell2)
    XCTAssert(!cell1.isLinkedWith(cell2))
    XCTAssert(!cell2.isLinkedWith(cell1))

    XCTAssert(cell1.links.isEmpty)
    XCTAssert(cell2.links.isEmpty)
  }
}
