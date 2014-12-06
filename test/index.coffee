assert  = require("assert")
huffman = require("../index.coffee")

testCodes = (alphabet, elements)->
  huffman elements, {alphabet}, (item, code)->
    assert code == item.expected,
      """code: "#{code}", item: #{JSON.stringify(item)}"""


suite "huffman", ->

  suite "binary", ->

    test "one element", ->
      testCodes "01", [
        {value: "a", weight: 4, expected: "0"}
      ]


    test "two elements", ->
      testCodes "01", [
        {value: "a", weight: 4, expected: "0"}
        {value: "b", weight: 3, expected: "1"}
      ]


    test "three elements", ->
      testCodes "01", [
        {value: "a", weight: 4, expected: "00"}
        {value: "b", weight: 3, expected: "01"}
        {value: "c", weight: 6, expected: "1"}
      ]

    test "four elements", ->
      testCodes "01", [
        {value: "a", weight: 4, expected: "000"}
        {value: "b", weight: 3, expected: "001"}
        {value: "c", weight: 6, expected: "01"}
        {value: "d", weight: 8, expected: "1"}
      ]


  test "ternary", ->
    testCodes "ABC", [
      {value: "a", weight: 4, expected: "BA"}
      {value: "b", weight: 3, expected: "BB"}
      {value: "c", weight: 6, expected: "C"}
      {value: "d", weight: 8, expected: "A"}
    ]


  test "longer alphabet than list", ->
    # Higher weight, earlier letter.
    testCodes "ABCDEF", [
      {value: "a", weight: 4, expected: "C"}
      {value: "b", weight: 3, expected: "D"}
      {value: "c", weight: 6, expected: "B"}
      {value: "d", weight: 8, expected: "A"}
    ]


  test "Equal weights", ->
    testCodes "01", [
      {value: "a", weight: 1, expected: "010"}
      {value: "b", weight: 1, expected: "011"}
      {value: "c", weight: 1, expected: "000"}
      {value: "d", weight: 1, expected: "001"}
      {value: "e", weight: 1, expected: "10"}
      {value: "f", weight: 1, expected: "11"}
    ]


  test "“Unusual” weights", ->
    testCodes "01", [
      {value: "a", weight:    -4, expected: "111"}
      {value: "b", weight:     0, expected: "110"}
      {value: "c", weight:  18.3, expected: "0"}
      {value: "d", weight:     9, expected: "10"}
    ]


  test "QWERTY home row", ->
    testCodes "fjdksla;", [
      {value: "a", weight: 4,      expected: "kl"}
      {value: "b", weight: 1201,   expected: "f"}
      {value: "c", weight: 254.56, expected: "a"}
      {value: "d", weight: 202,    expected: ";"}
      {value: "e", weight: 578,    expected: "j"}
      {value: "f", weight: 104,    expected: "kj"}
      {value: "g", weight: 48.5,   expected: "kd"}
      {value: "h", weight: 198,    expected: "kf"}
      {value: "i", weight: 18,     expected: "ks"}
      {value: "j", weight: 286,    expected: "s"}
      {value: "k", weight: 463,    expected: "d"}
      {value: "l", weight: 32,     expected: "kk"}
      {value: "m", weight: 271,    expected: "l"}
    ]


  test "empty list", ->
    huffman [], {alphabet: "01"}, ->
      assert false, "Expected callback not to run"


  test "prevent infinite recursion", ->
    assert.throws (-> huffman [], {alphabet: "" }, ->), RangeError
    assert.throws (-> huffman [], {alphabet: "0"}, ->), RangeError
