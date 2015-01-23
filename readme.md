Overview [![Build Status](https://travis-ci.org/lydell/n-ary-huffman.svg?branch=master)](https://travis-ci.org/lydell/n-ary-huffman)
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

`createTree(elements, n, [options])`
------------------------------------

`elements` is an array of objects. Each object is expected to have a `weight`
property which represents the _weight_ of the object, which is a number.

Returns a new `BranchPoint`—the root of an `n`-ary huffman tree, consisting of
all the items in `elements` as well as `BranchPoint`s. Each `BranchPoint` has
`n` children (except the deepest one which might have fewer, depending on
`elements.length`).

`options`:

- sorted: `Boolean`. Defaults to `false`. In order to create the tree,
  `elements` needs to be sorted after the weights in ascending order. Enable
  this option if `elements` already is sorted this way, to skip sorting again.

`new BranchPoint(elements, weight)`
-----------------------------------

Instances have the arguments as properties.

`BranchPoint.prototype.assignCodeWords(alphabet, callback, prefix="")`
----------------------------------------------------------------------

Assign a _code word_ to each element in the tree. The larger the weight of an
element, the shorter the code word.

`alphabet` is a string or an array of characters to use for the code words. Make
sure that the alphabet is at least as long the arity of the tree. Note: Don’t
repeat characters, or you’ll get invalid code words.

`callback(element, codeWord)` is run for each object in the tree.

`prefix` (optional) will be added at the beginning of each code word.


License
=======

[The X11 “MIT” License](LICENSE).
