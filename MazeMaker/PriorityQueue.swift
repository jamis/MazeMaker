public enum PriorityWeighting {
  case LowestFirst, HighestFirst
}

public class PriorityQueue<U: Hashable> {
  public typealias Pair = (item: U, priority: Int)

  private let heap: BinaryHeap<Pair>
  private var priorities: [U: Int] = [:]

  public var isEmpty: Bool {
    return heap.isEmpty
  }

  public init(compare: (Pair, Pair) -> HeapComparisonResult) {
    heap = BinaryHeap<Pair>(compare: compare)
  }

  public convenience init(weighting: PriorityWeighting) {
    let lowestFirst = { (a: Pair, b: Pair) -> HeapComparisonResult in
        if a.priority < b.priority {
          return .Higher
        } else if a.priority > b.priority {
          return .Lower
        } else {
          return .Equal
        }
      }

    let highestFirst = { (a: Pair, b: Pair) -> HeapComparisonResult in
      if a.priority > b.priority {
        return .Higher
      } else if a.priority < b.priority {
        return .Lower
      } else {
        return .Equal
      }
    }

    switch weighting {
    case .LowestFirst:
      self.init(compare: lowestFirst)
    case .HighestFirst:
      self.init(compare: highestFirst)
    }
  }

  public subscript(element: U) -> Int? {
    get {
      return priorities[element]
    }

    set(newValue) {
      let newValue = newValue!

      if let priority = priorities[element] {
        heap.deleteElement((element, priority))
      }

      heap.insert((element, newValue))
      priorities[element] = newValue
    }
  }

  public func fromCollection<S: CollectionType where S.Generator.Element == Pair>(collection: S) {
    priorities.removeAll()

    for pair in collection {
      priorities[pair.item] = pair.priority
    }

    heap.buildHeap(collection)
  }

  public func next() -> Pair? {
    if let pair = heap.delete() {
      priorities.removeValueForKey(pair.item)
      return pair
    }

    return nil
  }
}