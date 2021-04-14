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

@module("react-flow-renderer")
external jsGetOutgoers: (rawElement, rawElements) => rawElements = "getOutgoers"

@module("react-flow-renderer")
external jsGetIncomers: (rawElement, rawElements) => rawElements = "getIncomers"

@module("react-flow-renderer")
external jsGetConnectedEdges: (rawElements, rawElements) => rawElements = "getConnectedEdges"

@module("react-flow-renderer")
external getTransformForBounds: (
  ~bounds: rect,
  ~width: float,
  ~height: float,
  ~minZoom: float,
  ~maxZoom: float,
  ~padding: float=?,
) => transform = "getTransformForBounds"

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
  rawToElements(jsAddEdge(elemToAdd, elementsToRaw(elems)))
}

let removeElements = (~elemsToRemove: rawElements, ~elems: elements) => {
  rawToElements(jsRemoveElements(elemsToRemove, elementsToRaw(elems)))
}

let updateEdge = (~oldEdge: Edge.t, ~newConnection: connection, ~elems: elements) => {
  rawToElements(jsUpdateEdge(elemToRaw(oldEdge), elemToRaw(newConnection), elementsToRaw(elems)))
}

let getOutgoers = (~node: Node.t, ~elems: elements): array<Node.t> => {
  jsGetOutgoers(elemToRaw(node), elementsToRaw(elems))->Belt.Array.map(rawToNode)
}

let getIncomers = (~node: Node.t, ~elems: elements): array<Node.t> => {
  jsGetIncomers(elemToRaw(node), elementsToRaw(elems))->Belt.Array.map(rawToNode)
}

let getConnectedEdges = (~nodes: array<Node.t>, ~edges: array<Edge.t>): array<Edge.t> => {
  jsGetConnectedEdges(
    elementsToRaw(nodes->Belt.Array.map(n => Node(n))),
    elementsToRaw(edges->Belt.Array.map(e => Edge(e))),
  )->Belt.Array.map(rawToEdge)
}
