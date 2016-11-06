// Generated by CoffeeScript 1.11.1

/*
 * Copyright 2014, 2015, 2016 Simon Lydell
 * X11 (“MIT”) Licensed. (See LICENSE.)
 */
var BranchPoint, createTree;

createTree = function(elements, numBranches, options) {
  var branchPointIndex, branchPoints, childIndex, children, compare, element, elementIndex, latestBranchPointIndex, lowestWeight, nextBranchPoint, nextElement, numBranchPoints, numChildren, numElements, numPadding, ref, ref1, root, sorted, weight;
  if (options == null) {
    options = {};
  }
  sorted = (ref = options.sorted) != null ? ref : false, compare = (ref1 = options.compare) != null ? ref1 : function(a, b) {
    return a.weight - b.weight;
  };
  if (!(numBranches >= 2)) {
    throw new RangeError("`n` must be at least 2");
  }
  numElements = elements.length;
  if (numElements === 0) {
    return new BranchPoint([], 0);
  }
  if (numElements === 1) {
    element = elements[0];
    return new BranchPoint([element], element.weight);
  }
  if (!sorted) {
    elements = elements.slice(0).sort(function(a, b) {
      return compare(b, a);
    });
  }
  numBranchPoints = Math.ceil((numElements - 1) / (numBranches - 1));
  numPadding = 1 + (numBranches - 1) * numBranchPoints - numElements;
  branchPoints = Array(numBranchPoints);
  latestBranchPointIndex = 0;
  branchPointIndex = 0;
  elementIndex = numElements - 1;
  if (numPadding > 0) {
    numChildren = numBranches - numPadding;
    weight = 0;
    children = Array(numChildren);
    childIndex = 0;
    while (childIndex < numChildren) {
      element = elements[elementIndex];
      children[childIndex] = element;
      weight += element.weight;
      elementIndex--;
      childIndex++;
    }
    branchPoints[0] = new BranchPoint(children, weight);
    latestBranchPointIndex = 1;
  }
  nextElement = elementIndex >= 0 ? elements[elementIndex] : null;
  while (latestBranchPointIndex < numBranchPoints) {
    weight = 0;
    children = Array(numBranches);
    childIndex = 0;
    nextBranchPoint = branchPoints[branchPointIndex];
    while (childIndex < numBranches) {
      if ((nextElement == null) || ((nextBranchPoint != null) && compare(nextBranchPoint, nextElement) <= 0)) {
        lowestWeight = nextBranchPoint;
        branchPointIndex++;
        nextBranchPoint = branchPoints[branchPointIndex];
      } else {
        lowestWeight = nextElement;
        elementIndex--;
        nextElement = elementIndex >= 0 ? elements[elementIndex] : null;
      }
      children[childIndex] = lowestWeight;
      weight += lowestWeight.weight;
      childIndex++;
    }
    branchPoints[latestBranchPointIndex] = new BranchPoint(children, weight);
    latestBranchPointIndex++;
  }
  root = branchPoints[numBranchPoints - 1];
  return root;
};

BranchPoint = (function() {
  function BranchPoint(children1, weight1) {
    this.children = children1;
    this.weight = weight1;
  }

  BranchPoint.prototype.assignCodeWords = function(alphabet, callback, prefix) {
    var codeWord, i, index, node, ref;
    if (prefix == null) {
      prefix = "";
    }
    index = 0;
    ref = this.children;
    for (i = ref.length - 1; i >= 0; i += -1) {
      node = ref[i];
      codeWord = prefix + alphabet[index++];
      if (node instanceof BranchPoint) {
        node.assignCodeWords(alphabet, callback, codeWord);
      } else {
        callback(node, codeWord);
      }
    }
  };

  return BranchPoint;

})();

module.exports = {
  createTree: createTree,
  BranchPoint: BranchPoint
};
