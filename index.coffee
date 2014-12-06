###
# Copyright 2014 Simon Lydell
# X11 (“MIT”) Licensed. (See LICENSE.)
###

module.exports = (originalElements, { alphabet }, callback)->
  unless alphabet.length >= 2
    throw new RangeError("`options.alphabet` must consist of at least two
                         characters.")

  # Shallow working copy.
  elements = originalElements[..]

  # The Huffman algorithm is so optimized, that it does not produce a code word
  # at all if there is only one element! However, this implementation _always_
  # produces one code word for each item in `elements`.
  if elements.length <= 1
    callback(elements[0], alphabet[0]) if elements.length == 1
    return

  numBranches = alphabet.length
  numElements = elements.length

  # The Huffman algorithm needs to create a `numBranches`-ary tree (one branch
  # for each character in the `alphabet`). Such a tree can be formed by `1 +
  # (numBranches - 1) * n` elements: There is the root of the tree (`1`), and
  # each branching adds `numBranches` elements to the total number or elements,
  # but replaces itself (`numBranches - 1`). `n` is the number of points where
  # the tree branches. In order to create the tree using `numElements` elements,
  # we need to find an `n` such that `1 + (numBranches - 1) * n >= numElements`
  # (1), and then pad `numElements`, such that `1 + (numBranches - 1) * n ==
  # numElements + padding` (2).
  #
  # Solving for `n = numBranchPoints` in (1) gives:
  numBranchPoints = Math.ceil((numElements - 1) / (numBranches - 1))
  # Solving for `padding` in (2) gives:
  padding = 1 + (numBranches - 1) * numBranchPoints - numElements

  # Sort the elements after their weights, in descending order, so that the last
  # ones will be the ones with lowest weight.
  elements.sort((a, b)-> b.weight - a.weight)

  # Pad with zero-weights to be able to form a `numBranches`-ary tree.
  for i in [0...padding] by 1
    elements.push(new Padding)

  # Construct the Huffman tree.
  for i in [0...numBranchPoints] by 1
    # Replace `numBranches` of the lightest weights with their sum.
    sum = new BranchingPoint
    for i in [0...numBranches] by 1
      lowestWeight = elements.pop()
      sum.weight += lowestWeight.weight
      sum.children.unshift(lowestWeight)

    # Find the index to insert the sum so that the sorting is maintained. This
    # is faster than sorting the elements in each iteration.
    break for element, index in elements by -1 when sum.weight <= element.weight
    elements.splice(index + 1, 0, sum)

  [root] = elements # `elements.length == 1` by now.

  # Create the code words by walking the tree. Store them using `callback`.
  do walk = (node=root, codeWord="")->
    if node instanceof BranchingPoint
      for childNode, index in node.children
        walk(childNode, codeWord + alphabet[index])
    else
      callback(node, codeWord) unless node instanceof Padding
    return


class Padding
  weight: 0

class BranchingPoint
  constructor: ->
    @weight = 0
    @children = []
