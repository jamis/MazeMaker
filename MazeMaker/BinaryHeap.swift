public enum HeapComparisonResult {
  case Higher, Equal, Lower
}

public class BinaryHeap<U> {
  private var list: [U] = []
  private let compare: (U, U) -> HeapComparisonResult

  public var isEmpty: Bool {
    return list.isEmpty
  }

  public init(compare: (U, U) -> HeapComparisonResult) {
    self.compare = compare
  }

  public func insert(value: U) {
    list.append(value)

    var child = list.count - 1
    while child > 0 {
      let parent = (child - 1) / 2
      if compare(list[child], list[parent]) == .Higher {
        let tmp = list[child]
        list[child] = list[parent]
        list[parent] = tmp
        child = parent
      } else {
        break
      }
    }
  }

  public func buildHeap<S: CollectionType where S.Generator.Element == U>(list: S) {
    self.list = Array(list)
    reheapify()
  }

  public func peek() -> U? {
    return list[0]
  }

  public func delete() -> U? {
    let value = list[0]
    let least = list.popLast()

    if list.count > 0 {
      list[0] = least!
      heapifyFrom(0)
    }

    return value
  }

  public func deleteElement(element: U) -> U? {
    if let index = searchSubtree(0, forElement: element) {
      deleteAt(index)
      return element
    }

    return nil
  }

  private func deleteAt(index: Int) {
    if index > 0 {
      let tmp = list[0]
      list[0] = list[index]
      list[index] = list[list.count-1]
      list[list.count-1] = tmp
    }

    delete()
  }

  private func searchSubtree(root: Int, forElement element: U) -> Int? {
    let left = root * 2 + 1
    let right = root * 2 + 2

    switch compare(element, list[root]) {
    case .Higher:
      return nil // no match

    case .Equal:
      return root

    case .Lower:
      let leftWise = (left < list.count) ? compare(element, list[left]) : .Higher
      if leftWise != .Higher {
        if let result = searchSubtree(left, forElement: element) {
          return result
        }
      }

      let rightWise = (right < list.count) ? compare(element, list[right]) : .Higher
      if rightWise != .Higher {
        if let result = searchSubtree(right, forElement: element) {
          return result
        }
      }
    }
    
    return nil
  }

  private func reheapify() {
    var i = (list.count - 2) / 2
    while i >= 0 {
      heapifyFrom(i)
      i--
    }
  }

  private func heapifyFrom(root: Int) {
    let left = root * 2 + 1
    let right = root * 2 + 2

    var highest = root

    if right < list.count && compare(list[right], list[root]) == .Higher && compare(list[right], list[left]) == .Higher {
      highest = right
    } else if left < list.count && compare(list[left], list[root]) == .Higher {
      highest = left
    }

    if highest != root {
      let tmp = list[root]
      list[root] = list[highest]
      list[highest] = tmp
      heapifyFrom(highest)
    }
  }
}