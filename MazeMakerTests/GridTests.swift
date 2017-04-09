import XCTest
@testable import MazeMaker

class GridTests: XCTestCase {
  class TestLayout: Layout {
    func build(_ grid: Grid) {
    }

    func renderAsString(_ grid: Grid) -> String {
      return ""
    }
  }

  let grid = Grid(layout: TestLayout())

  func testGridShouldStartEmpty() {
    XCTAssert(grid.cells.isEmpty)
  }

  func testAddShouldInsertCellIntoGrid() {
    let cell = Cell(location: TestLocation(position: 1))

    grid.add(cell)
    XCTAssert(grid.cells.contains(cell))
  }

  func testRemoveShouldRemoveCellFromGrid() {
    let cell = Cell(location: TestLocation(position: 1))

    grid.add(cell)
    grid.remove(cell)

    XCTAssert(grid.cells.isEmpty)
  }

  func testAtShouldReturnCellAtLocation() {
    let cell1 = Cell(location: TestLocation(position: 1))
    let cell2 = Cell(location: TestLocation(position: 2))

    grid.add(cell1)
    grid.add(cell2)

    XCTAssertEqual(grid.at(cell1.location), cell1)
    XCTAssertEqual(grid.at(cell2.location), cell2)
  }

  func testSampleShouldReturnRandomCell() {
    let cell1 = Cell(location: TestLocation(position: 1))
    let cell2 = Cell(location: TestLocation(position: 2))

    grid.add(cell1)
    grid.add(cell2)

    let cell = grid.sample()
    XCTAssert(cell == cell1 || cell == cell2)
  }

  func testResetShouldResetLinksOfAllCells() {
    let cell1 = Cell(location: TestLocation(position: 1))
    let cell2 = Cell(location: TestLocation(position: 2))

    grid.add(cell1)
    grid.add(cell2)

    cell1.linkWith(cell2)
    XCTAssert(cell1.isLinkedWith(cell2));

    grid.reset()
    XCTAssert(!cell1.isLinkedWith(cell2));
  }
}
