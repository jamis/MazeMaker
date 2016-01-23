extension Set {
  public func sample() -> Set.Element? {
    if count > 0 {
      let offset = Int(arc4random_uniform(UInt32(count)))
      let index = startIndex.advancedBy(offset)
      return self[index]
    } else {
      return nil
    }
  }
}