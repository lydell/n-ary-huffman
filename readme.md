Overview [![Build Status](https://travis-ci.org/lydell/n-ary-huffman.png?branch=master)](https://travis-ci.org/lydell/n-ary-huffman)
========

```js
var huffman = require("n-ary-huffman")
var list = require("./list")

var elements = list.map(function(item) { item.weight = Math.random() })

huffman(elements, {alphabet: "0123"}, function(element, code) {
  console.log(element, code)
})
```

Installation
============

`npm install n-ary-huffman`


Usage
=====

`huffman(elements, options, callback)`
--------------------------------------

`elements` is an array of objects. Each object is expected to have a `weight`
property which represents the _weight_ of the object, which is a number. Each
object will be given a _code word._ The larger the weight, the shorter the code
word.

`options`:
  - alphabet: `String` or `Array`. The characters to use for the code words. If
    some characters are preferred over others, put them longer to the left.
    Note: Don’t repeat characters, or you’ll get invalid code words.

`callback(element, codeWord)` is run for each object in `elements`.


License
=======

[The X11 “MIT” License](LICENSE).
