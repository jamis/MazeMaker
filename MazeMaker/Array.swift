extension Array {
  public func sample() -> Array.Element? {
    if count > 0 {
      let offset = Int(arc4random_uniform(UInt32(count)))
      return self[offset]
    } else {
      return nil
    }
  }

  public func shuffle() -> Array {
    var copy = self

    for i in 0..<copy.count {
      let j = Int(arc4random_uniform(UInt32(i+1)))
      if i != j {
        let temp = copy[i]
        copy[i] = copy[j]
        copy[j] = temp
      }
    }

    return copy
  }
}