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
    var tree = huffman.createTree(elements, options.alphabet.length)
    tree.assignCodeWords(options.alphabet, callback)
  }
  ```
- Improved: Performance.

### Version 1.0.0 (2014-12-06) ###

- Initial release.
