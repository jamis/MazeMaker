extension Array {
  public func sample() -> Array.Element? {
    if count > 0 {
      let offset = Int(arc4random_uniform(UInt32(count)))
      return self[offset]
    } else {
      return nil
    }
  }
}