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

type rect = {
  x: int,
  y: int,
  width: int,
  height: int,
}

module Node = {
  type data

  external toData: 'anything => data = "%identity"

  @deriving(abstract)
  type t = {
    id: elementId,
    position: xyPosition,
    @optional @as("type") type_: string,
    @optional
    data: data,
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
  type data

  external toData: 'anything => data = "%identity"

  @deriving(abstract)
  type t = {
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
    data: data,
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

type connectionLineType = [#default | #straight | #step | #smoothstep]

type connectionLineComponentProps = {
  sourceX: int,
  sourceY: int,
  sourcePosition: option<position>,
  targetX: int,
  targetY: int,
  targetPosition: option<position>,
  connectionLineStyle: option<ReactDOM.Style.t>,
  connectionLineType: connectionLineType,
}

type connectionLineComponent = React.componentLike<connectionLineComponentProps, React.element>

type edgeOrConnection = Connection(connection) | Edge(Edge.t)

type flowElement = Node(Node.t) | Edge(Edge.t)

type elements = array<flowElement>

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

type flowExportObj = {
  elements: elements,
  position: (int, int),
  zoom: int,
}

type toObjFunc = unit => flowExportObj

type onLoadParams = {
  zoomIn: unit => unit,
  zoomOut: unit => unit,
  zoomTo: (~zoomLevel: int) => unit,
  fitView: fitViewFunc,
  project: projectFunc,
  getElements: unit => elements,
  setTransform: (~transform: flowTransform) => unit,
  toObject: toObjFunc,
}

type onConnectStartParams = {
  nodeId: option<elementId>,
  handleId: option<elementId>,
  handleType: [#source | #target],
}

type translateExtent = array<(int, int)>

type connectionMode = [#strict | #loose]

type selectionRect = {
  x: int,
  y: int,
  width: int,
  height: int,
  startX: int,
  startY: int,
  draw: bool,
}

type onConnectFunc = connection => unit
type onConnectStartFunc = (ReactEvent.Mouse.t, onConnectStartParams) => unit
type onConnectStopFunc = ReactEvent.Mouse.t => unit
type onConnectEndFunc = ReactEvent.Mouse.t => unit

module Handle = {
  type handleType = [#source | #target]

  type onConnectFunc = connection => unit

  type isValidConnectionFunc = connection => bool
}

type reactFlowState = {
  width: int,
  height: int,
  transform: transform,
  nodes: array<Node.t>,
  edges: array<Edge.t>,
  selectedElements: Js.nullable<elements>,
  selectedNodesBox: rect,
  minZoom: int,
  maxZoom: int,
  translateExtent: translateExtent,
  nodeExtent: translateExtent,
  nodesSelectionActive: bool,
  selectionActive: bool,
  userSelectionRect: selectionRect,
  connectionNodeId: Js.nullable<elementId>,
  connectionHandleId: Js.nullable<elementId>,
  connectionHandleType: Js.nullable<Handle.handleType>,
  connectionPosition: xyPosition,
  connectionMode: connectionMode,
  snapToGrid: bool,
  snapGrid: (int, int),
  nodesDraggable: bool,
  nodesConnectable: bool,
  elementsSelectable: bool,
  multiSelectionActive: bool,
  reactFlowVersion: string,
  onConnect: option<onConnectFunc>,
  onConnectStart: option<onConnectStartFunc>,
  onConnectStop: option<onConnectStopFunc>,
  onConnectEnd: option<onConnectEndFunc>,
}

type updateNodeInternals = elementId => unit

type nodePosUpdate = {
  id: elementId,
  pos: xyPosition,
}

type nodeDiffUpdate = {
  id: option<elementId>,
  diff: option<xyPosition>,
  isDragging: option<bool>,
}

type setConnectionId = {
  connectionNodeId: Js.nullable<elementId>,
  connectionHandleid: Js.nullable<elementId>,
  connectionHandleType: Js.nullable<Handle.handleType>,
}

type zoomPanHelperFunctions = {
  zoomIn: unit => unit,
  zoomOut: unit => unit,
  zoomTo: int => unit,
  transform: flowTransform => unit,
  fitView: fitViewFunc,
  setCenter: (~x: int, ~y: int, ~zoom: int=?) => unit,
  fitBounds: (~bounds: rect, ~padding: int=?) => unit,
  project: xyPosition => xyPosition,
  initialized: bool,
}

module MiniMap = {
  type stringFunc = Node.t => string
}

module Action = {
  type setOnConnect = onConnectFunc => unit

  type setOnConnectStart = onConnectStartFunc => unit

  type setOnConnectStop = onConnectStopFunc => unit

  type setOnConnectEnd = onConnectEndFunc => unit

  type setElements = rawElements => unit

  type updateNodePos = nodePosUpdate => unit

  type updateNodePosDiff = nodeDiffUpdate => unit

  type setUserSelection = xyPosition => unit

  type updateUserSelection = xyPosition => unit

  type unsetUserSelection = unit => unit

  type setSelection = bool => unit

  type unsetNodesSelection = unit => unit

  type resetSelectedElements = unit => unit

  type setSelectedElements = rawElements => unit

  type addSelectedElements = rawElements => unit

  type updateTransform = transform => unit

  type updateSize = dimensions => unit

  type setMinZoom = int => unit

  type setMaxZoom = int => unit

  type setTranslateExtent = translateExtent => unit

  type setConnectionPosition = xyPosition => unit

  type setConnectionNodeId = setConnectionId => unit

  type setSnapToGrid = bool => unit

  type setSnapGrid = (int, int) => unit

  type setInteractive = bool => unit

  type setNodesDraggable = bool => unit

  type setNodesConnectable = bool => unit

  type setElementsSelectable = bool => unit

  type setMultiSelectionActive = bool => unit

  type setConnectionMode = connectionMode => unit

  type setNodeExtent = translateExtent => unit

  type t = {
    setOnConnect: setOnConnect,
    setOnConnectStart: setOnConnectStart,
    setOnConnectStop: setOnConnectStop,
    setOnConnectEnd: setOnConnectEnd,
    setElements: setElements,
    updateNodePos: updateNodePos,
    updateNodePosDiff: updateNodePosDiff,
    setuserSelection: setUserSelection,
    updateUserSelection: updateUserSelection,
    unsetUserSelection: unsetUserSelection,
    setSelection: setSelection,
    unsetNodesSelection: unsetNodesSelection,
    resetSelectedElements: resetSelectedElements,
    setSelectedElements: setSelectedElements,
    addSelectedElements: addSelectedElements,
    updateTransform: updateTransform,
    updateSize: updateSize,
    setMinZoom: setMinZoom,
    setMaxZoom: setMaxZoom,
    setTranslateExtent: setTranslateExtent,
    setConnectionPosition: setConnectionPosition,
    setConnectionNodeId: setConnectionNodeId,
    setSnapToGrid: setSnapToGrid,
    setSnapGrid: setSnapGrid,
    setInteractive: setInteractive,
    setNodesDraggable: setNodesDraggable,
    setNodesConnectable: setNodesConnectable,
    setElementsSelectable: setElementsSelectable,
    setMultiSelectionActive: setMultiSelectionActive,
    setConnectionMode: setConnectionMode,
    setNodeExtent: setNodeExtent,
  }
}
