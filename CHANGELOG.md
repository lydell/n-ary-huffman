### Version 3.1.0 (2016-11-06) ###

- Added: You may now use custom weight comparison in `createTree()` by passing
  the `{compare: function(a, b) { return a.weight - b.weight }}` option.


### Version 3.0.0 (2016-09-08) ###

This release contains one single change, and it is a **breaking change.** That
change had to be done in order to fix an unintuitive behavior.

The “original order” of elements with equal weight previously happened to be
reversed, but is now preserved.

Previously, assigning code words to five equal-weight elements with the alphabet
"abcde" resulted in them getting the following code words, respectively:

    "e", "d", "c", "b", "a"

This is more logical, though:

    "a", "b", "c", "d", "e"

Let’s say you have a list of items in some defined order. Then, that list is
sorted in ascending order, by their weights. It means that items with lower
weights go first. But what about items with _equal_ weights? If the sort is
stable, they remain in their original order. In effect, they are internally
sorted in _descending_ order. It makes sense to think that the earlier an
element is in the original order, the more important it is, but now things
became the other way around.

In order to fix the above problem, **the elements must now be sorted in
_descending_ order** (instead of ascending).

Note that you can upgrade safely if you don’t use `{sorted: true}`.


### Version 2.1.1 (2015-01-23) ###

- Fixed: An error in the npm package. This version is otherwise identical to
  version 2.1.0.


### Version 2.1.0 (2015-01-23) ###

- Added: You may now skip the sorting in `createTree()` by passing the `{sorted:
  true}` option, as an optimization if you already know that the elements are
  sorted properly.


### Version 2.0.0 (2015-01-22) ###

- Changed: New API. Instead of exporting a single function, a
  `createTree(elements, n)` function as well as a `BranchPoint` constructor are
  exported. The creation of a huffman tree and the creation of code words are
  now separate. The `createTree` function returns a new `BranchPoint`—the tree.
  `BranchPoint.prototype.assignCodeWords(alphabet, callback)` takes care of the
  code word generation.

  The old `huffman` API function could be implemented like this:

  ```js
  var createTree = require("huffman").createTree

  function huffman(elements, options, callback) {
    var tree = createTree(elements, options.alphabet.length)
    tree.assignCodeWords(options.alphabet, callback)
  }
  ```
- Improved: Performance.

### Version 1.0.0 (2014-12-06) ###

- Initial release.
