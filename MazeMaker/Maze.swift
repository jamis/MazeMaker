public class Maze<L: LayoutInterface>: Grid<L> {
  public init(layout: L, algorithm: Algorithm) {
    super.init(layout: layout)
    algorithm.applyTo(self);
  }
}