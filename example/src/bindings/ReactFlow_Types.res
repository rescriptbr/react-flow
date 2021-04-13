type rawElement

type rawElements = array<rawElement>

type elementId = string

type transform = (int, int, int)

type position = [#left | #top | #right | #bottom]

type arrowHeadType = [#Arrow | #ArrowClosed]

type xyPosition = {x: int, y: int}

type dimensions = {
  width: int,
  height: int,
}

module Node = {
  @deriving(abstract)
  type t<'a> = {
    id: elementId,
    position: xyPosition,
    @optional @as("type") type_: string,
    @optional
    data: 'a,
    @optional
    style: ReactDOM.Style.t,
    @optional
    className: string,
    @optional
    targetPosition: position,
    @optional
    sourcePosition: position,
    @optional
    isHidden: bool,
    @optional
    draggable: bool,
    @optional
    selectable: bool,
    @optional
    connectable: bool,
  }

  let makeNode = t
}

module Edge = {
  @deriving(abstract)
  type t<'a> = {
    id: elementId,
    source: elementId,
    target: elementId,
    @optional @as("type") type_: string,
    @optional
    sourceHandle: elementId,
    @optional
    targetHandle: elementId,
    @optional
    label: string,
    @optional
    labelStyle: ReactDOM.Style.t,
    @optional
    labelShowBg: bool,
    @optional
    labelBgStyle: ReactDOM.Style.t,
    @optional
    labelBdPadding: (int, int),
    @optional
    labelBgBorderRadius: int,
    @optional
    style: ReactDOM.Style.t,
    @optional
    animated: bool,
    @optional
    arrowHeadType: arrowHeadType,
    @optional
    isHidden: bool,
    @optional
    data: 'a,
    @optional
    className: string,
  }

  let makeEdge = t
}

type connection = {
  source: option<elementId>,
  target: option<elementId>,
  sourceHandle: option<elementId>,
  targetHandle: option<elementId>,
}

type edgeOrConnection<'a> = Connection(connection) | Edge(Edge.t<'a>)

type flowElement<'a> = Node(Node.t<'a>) | Edge(Edge.t<'a>)

type elements<'a> = array<flowElement<'a>>

type fitViewParams = {
  padding: option<int>,
  includeHiddenNodes: option<bool>,
}

type flowTransform = {
  x: int,
  y: int,
  zoom: int,
}

type fitViewFunc = fitViewParams => unit

type projectFunc = (~position: xyPosition) => xyPosition

type flowExportObj<'a> = {
  elements: elements<'a>,
  position: (int, int),
  zoom: int,
}

type toObjFunc<'a> = unit => flowExportObj<'a>

type onLoadParams<'a> = {
  zoomIn: unit => unit,
  zoomOut: unit => unit,
  zoomTo: (~zoomLevel: int) => unit,
  fitView: fitViewFunc,
  project: projectFunc,
  getElements: unit => elements<'a>,
  setTransform: (~transform: flowTransform) => unit,
  toObject: toObjFunc<'a>,
}

type onConnectStartParams = {
  nodeId: option<elementId>,
  handleId: option<elementId>,
  handleType: [#source | #target],
}

type onConnectStartFunc = (ReactEvent.Mouse.t, onConnectStartParams) => unit
type onConnectStopFunc = ReactEvent.Mouse.t => unit
type onConnectEndFunc = ReactEvent.Mouse.t => unit

module Handle = {
  type handleType = [#source | #target]

  type onConnectFunc = connection => unit

  type isValidConnectionFunc = connection => bool
}

module MiniMap = {
  type t
  type stringFunc = rawElement => string
}

@module("react-flow-renderer")
external isEdge: rawElement => bool = "isEdge"

@module("react-flow-renderer")
external isNode: rawElement => bool = "isNode"

@module("react-flow-renderer")
external jsRemoveElements: (rawElements, rawElements) => rawElements = "removeElements"

@module("react-flow-renderer")
external jsAddEdge: (rawElement, rawElements) => rawElements = "addEdge"
