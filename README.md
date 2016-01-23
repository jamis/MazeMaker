# MazeMaker

This is a collection of utilities, written in Swift, for instantiating,
manipulating, and rendering grids. It is specifically designed for representing
and creating mazes--randomly generated spanning trees on these grids.

## Usage

First, instantiate a layout, and a grid that uses that layout:

```swift
import MazeMaker

let layout = OrthogonalLayout(rows: 10, columns: 10)
let grid = Grid(layout: layout)
```

Then, apply an algorithm to the grid:

```swift
let algo = AldousBroder()
algo.applyTo(grid)
```

Finally, display it:

```swift
print(grid.toString())
```

## Caveats

As this is my first Swift project, I'm sure I'm doing all kinds of things
in all kinds of questionable ways. I would love feedback directing me towards
better ways of representing this in Swift, including (but not limited to)
more idiomatic code, more efficient techniques, and how to make better use of
what Swift provides.

## Author

Jamis Buck <jamis@jamisbuck.org>
