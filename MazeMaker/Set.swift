extension Set {
  public func sample() -> Set.Element? {
    if count > 0 {
        let offset = Int(arc4random()) % count
    
        let nIndex = index(startIndex, offsetBy: offset)//index.index(startIndex, offsetBy: offset)
        return self[nIndex]
    } else {
        return nil
    }
  }
}
