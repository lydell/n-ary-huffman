Overview [![Build Status](https://travis-ci.org/lydell/n-ary-huffman.png?branch=master)](https://travis-ci.org/lydell/n-ary-huffman)
========

```js
var huffman = require("n-ary-huffman")
var list = require("./list")

var elements = list.map(function(item) { item.weight = Math.random() })
var alphabet = "0123"

var tree = huffman.createTree(elements, alphabet.length)
tree.assignCodeWords(alphabet, function(element, code) {
  console.log(element, code)
})
```

Installation
============

`npm install n-ary-huffman`

```js
var huffman = require('n-ary-huffman')
```


Usage
=====

`createTree(elements, n)`
-------------------------

Returns a new `BranchingPoint`—the root of an `n`-ary huffman tree, consisting
of all the items in `elements` as well as other `BranchingPoints` and `Padding`.
Each `BranchingPoint` has `n` children.

`elements` is should be a valid argument to `new BranchingPoint`.

`new BranchingPoint(elements)`
------------------------------

`elements` is an array of objects. Each object is expected to have a `weight`
property which represents the _weight_ of the object, which is a number.

The returned object gets the following properties:

- `children`: `elements`
- `weight`: The sum of the `weight`s of `elements`.

`BranchingPoint.prototype.assignCodeWords(alphabet, callback, prefix="")`
-------------------------------------------------------------------------

Assign a _code word_ to each element in the tree. The larger the weight of a
child, the shorter the code word.

`alphabet` is a string or an array of characters to use for the code words. Make
sure that the alphabet is at least as long the arity of the tree. Note: Don’t
repeat characters, or you’ll get invalid code words.

`callback(element, codeWord)` is run for each object in the tree.

`prefix` (optional) will be added at the beginning of each code word.

`new Padding`
-------------

To be able to form an n-ary tree, the `createTree(elements, n)` function might
need to pad the `elements` array; such padding elements are instances of this
constructor.


License
=======

[The X11 “MIT” License](LICENSE).
