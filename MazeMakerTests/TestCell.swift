@testable import MazeMaker

class TestLocation: Location {
  fileprivate(set) var position: Int = 0

  init(position: Int) {
    self.position = position
  }

  override var hashValue: Int {
    return position
  }
}

func ==(lhs: TestLocation, rhs: TestLocation) -> Bool {
  return lhs.position == rhs.position
}
