###
# Copyright 2014, 2015 Simon Lydell
# X11 (“MIT”) Licensed. (See LICENSE.)
###

createTree = (originalElements, numBranches)->
  unless numBranches >= 2
    throw new RangeError("`numBranches` must be at least 2")

  # Shallow working copy.
  elements = originalElements[..]
  numElements = elements.length

  # Sort the elements after their weights, in descending order, so that the last
  # ones will be the ones with lowest weight.
  elements.sort((a, b)-> b.weight - a.weight)

  # Optimization.
  if numElements <= numBranches
    return new BranchingPoint(elements)

  # A `numBranches`-ary tree can be formed by `1 + (numBranches - 1) * n`
  # elements: There is the root of the tree (`1`), and each branching adds
  # `numBranches` elements to the total number or elements, but replaces itself
  # (`numBranches - 1`). `n` is the number of points where the tree branches. In
  # order to create the tree using `numElements` elements, we need to find an
  # `n` such that `1 + (numBranches - 1) * n >= numElements` (1), and then pad
  # `numElements`, such that `1 + (numBranches - 1) * n == numElements +
  # padding` (2).
  #
  # Solving for `n = numBranchPoints` in (1) gives:
  numBranchPoints = Math.ceil((numElements - 1) / (numBranches - 1))
  # Solving for `padding` in (2) gives:
  padding = 1 + (numBranches - 1) * numBranchPoints - numElements

  # Pad with zero-weights to be able to form a `numBranches`-ary tree.
  for i in [0...padding] by 1
    elements.push(new Padding)

  # Construct the Huffman tree.
  for i in [0...numBranchPoints] by 1
    # Replace `numBranches` of the lightest weights with their sum.
    sum = new BranchingPoint(elements.splice(-numBranches, numBranches))

    # Find the index to insert the sum so that the sorting is maintained. This
    # is faster than sorting the elements in each iteration.
    break for element, index in elements by -1 when sum.weight <= element.weight
    elements.splice(index + 1, 0, sum)

  [root] = elements # `elements.length == 1` by now.
  root

class Padding
  weight: 0

class BranchingPoint
  constructor: (@children)->
    @weight = @children.reduce(((sum, element)-> sum + element.weight), 0)

  assignCodeWords: (alphabet, callback, prefix="")->
    for node, index in @children
      codeWord = prefix + alphabet[index]
      if node instanceof BranchingPoint
        node.assignCodeWords(alphabet, callback, codeWord)
      else
        callback(node, codeWord) unless node instanceof Padding
    return

module.exports = {createTree, Padding, BranchingPoint}
