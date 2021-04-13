open ReactFlow_Types

@module("react-flow-renderer")
external isEdge: rawElement => bool = "isEdge"

@module("react-flow-renderer")
external isNode: rawElement => bool = "isNode"

@module("react-flow-renderer")
external jsRemoveElements: (rawElements, rawElements) => rawElements = "removeElements"

@module("react-flow-renderer")
external jsAddEdge: (rawElement, rawElements) => rawElements = "addEdge"

@module("react-flow-renderer")
external jsUpdateEdge: (rawElement, rawElement, rawElements) => rawElements = "updateEdge"

external rawToNode: rawElement => Node.t = "%identity"

external rawToEdge: rawElement => Edge.t = "%identity"

external elemToRaw: 'a => rawElement = "%identity"

external miniMapString: string => MiniMap.t = "%identity"

external miniMapStringFunc: MiniMap.stringFunc => MiniMap.t = "%identity"

let unwrapElem = elem => {
  switch elem {
  | Node(elem) => elemToRaw(elem)
  | Edge(elem) => elemToRaw(elem)
  }
}

let elementsToRaw = (elems): rawElements => {
  elems->Belt.Array.map(unwrapElem)
}

let rawToElements = rawElements => {
  rawElements->Belt.Array.map(elem => {
    if isNode(elem) {
      Node(rawToNode(elem))
    } else {
      Edge(rawToEdge(elem))
    }
  })
}

let addEdge = (~elemToAdd: rawElement, ~elems: elements) => {
  jsAddEdge(elemToAdd, elementsToRaw(elems))
}

let removeElements = (~elemsToRemove: rawElements, ~elems: elements) => {
  jsRemoveElements(elemsToRemove, elementsToRaw(elems))
}

let updateEdge = (~oldEdge: Edge.t, ~newConnection: connection, ~elems: elements) => {
  jsUpdateEdge(elemToRaw(oldEdge), elemToRaw(newConnection), elementsToRaw(elems))
}
