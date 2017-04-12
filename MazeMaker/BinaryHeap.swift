public enum HeapComparisonResult {
  case higher, equal, lower
}

open class BinaryHeap<U> {
  fileprivate var list: [U] = []
  fileprivate let compare: (U, U) -> HeapComparisonResult

  open var isEmpty: Bool {
    return list.isEmpty
  }

  public init(compare: @escaping (U, U) -> HeapComparisonResult) {
    self.compare = compare
  }

  open func insert(_ value: U) {
    list.append(value)

    var child = list.count - 1
    while child > 0 {
      let parent = (child - 1) / 2
      if compare(list[child], list[parent]) == .higher {
        let tmp = list[child]
        list[child] = list[parent]
        list[parent] = tmp
        child = parent
      } else {
        break
      }
    }
  }

  open func buildHeap<S: Collection where S.Iterator.Element == U>(_ list: S) {
    self.list = Array(list)
    reheapify()
  }

  open func peek() -> U? {
    return list[0]
  }

  open func delete() -> U? {
    let value = list[0]
    let least = list.popLast()

    if list.count > 0 {
      list[0] = least!
      heapifyFrom(0)
    }

    return value
  }

  open func deleteElement(_ element: U) -> U? {
    if let index = searchSubtree(0, forElement: element) {
      deleteAt(index)
      return element
    }

    return nil
  }

  fileprivate func deleteAt(_ index: Int) {
    if index > 0 {
      let tmp = list[0]
      list[0] = list[index]
      list[index] = list[list.count-1]
      list[list.count-1] = tmp
    }

    delete()
  }

  fileprivate func searchSubtree(_ root: Int, forElement element: U) -> Int? {
    let left = root * 2 + 1
    let right = root * 2 + 2

    switch compare(element, list[root]) {
    case .higher:
      return nil // no match

    case .equal:
      return root

    case .lower:
      let leftWise = (left < list.count) ? compare(element, list[left]) : .higher
      if leftWise != .higher {
        if let result = searchSubtree(left, forElement: element) {
          return result
        }
      }

      let rightWise = (right < list.count) ? compare(element, list[right]) : .higher
      if rightWise != .higher {
        if let result = searchSubtree(right, forElement: element) {
          return result
        }
      }
    }
    
    return nil
  }

  fileprivate func reheapify() {
    var i = (list.count - 2) / 2
    while i >= 0 {
      heapifyFrom(i)
      i -= 1
    }
  }

  fileprivate func heapifyFrom(_ root: Int) {
    let left = root * 2 + 1
    let right = root * 2 + 2

    var highest = root

    if right < list.count && compare(list[right], list[root]) == .higher && compare(list[right], list[left]) == .higher {
      highest = right
    } else if left < list.count && compare(list[left], list[root]) == .higher {
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
