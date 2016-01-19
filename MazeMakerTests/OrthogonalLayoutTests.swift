import XCTest
@testable import MazeMaker

class OrthogonalLayoutTests: XCTestCase {

  func testLayoutShouldPopulateGridOfCells() {
    let layout = OrthogonalLayout(rows: 3, columns: 3)
    let grid = Grid(layout: layout)

    let a = grid.at(GridLocation(row: 0, column: 0)) as! OrthogonalCell
    let b = grid.at(GridLocation(row: 0, column: 1)) as! OrthogonalCell
    let c = grid.at(GridLocation(row: 0, column: 2)) as! OrthogonalCell
    let d = grid.at(GridLocation(row: 1, column: 0)) as! OrthogonalCell
    let e = grid.at(GridLocation(row: 1, column: 1)) as! OrthogonalCell
    let f = grid.at(GridLocation(row: 1, column: 2)) as! OrthogonalCell
    let g = grid.at(GridLocation(row: 2, column: 0)) as! OrthogonalCell
    let h = grid.at(GridLocation(row: 2, column: 1)) as! OrthogonalCell
    let i = grid.at(GridLocation(row: 2, column: 2)) as! OrthogonalCell

    XCTAssertNil(a.north)
    XCTAssertNil(a.west)
    XCTAssertEqual(a.east, b)
    XCTAssertEqual(a.south, d)

    XCTAssertNil(b.north)
    XCTAssertEqual(b.west, a)
    XCTAssertEqual(b.east, c)
    XCTAssertEqual(b.south, e)

    XCTAssertNil(c.north)
    XCTAssertNil(c.east)
    XCTAssertEqual(c.west, b)
    XCTAssertEqual(c.south, f)

    XCTAssertNil(d.west)
    XCTAssertEqual(d.north, a)
    XCTAssertEqual(d.east, e)
    XCTAssertEqual(d.south, g)

    XCTAssertEqual(e.north, b)
    XCTAssertEqual(e.west, d)
    XCTAssertEqual(e.east, f)
    XCTAssertEqual(e.south, h)

    XCTAssertNil(f.east)
    XCTAssertEqual(f.north, c)
    XCTAssertEqual(f.west, e)
    XCTAssertEqual(f.south, i)

    XCTAssertNil(g.west)
    XCTAssertNil(g.south)
    XCTAssertEqual(g.north, d)
    XCTAssertEqual(g.east, h)

    XCTAssertNil(h.south)
    XCTAssertEqual(h.north, e)
    XCTAssertEqual(h.west, g)
    XCTAssertEqual(h.east, i)

    XCTAssertNil(i.east)
    XCTAssertNil(i.south)
    XCTAssertEqual(i.north, f)
    XCTAssertEqual(i.west, h)
  }
}