extension Set {
  public func sample() -> Set.Element? {
    if count > 0 {
      let offset = Int(rand()) % count
      let index = startIndex.advancedBy(offset)
      return self[index]
    } else {
      return nil
    }
  }
}