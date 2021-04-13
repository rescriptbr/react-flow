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

external identity: 'a => 'b = "%identity"

let unwrap = elem => {
  switch elem {
  | Node(elem) => identity(elem)
  | Edge(elem) => identity(elem)
  }
}

let convertElemsToJs = elems => {
  elems->Belt.Array.map(unwrap)
}

type outsiderElement = {
  id: string,
  target: option<string>,
  source: option<string>,
  sourceHandle: option<string>,
  targetHandle: option<string>,
}

type outsiderEdge = {
  source: string,
  sourceHandle: option<string>,
  target: string,
  targetHandle: option<string>,
}

type onConnectStartParams = {
  nodeId: option<elementId>,
  handleId: option<elementId>,
  handleType: [#source | #target],
}

type onConnectStartFunc = (ReactEvent.Mouse.t, onConnectStartParams) => unit
type onConnectStopFunc = ReactEvent.Mouse.t => unit
type onConnectEndFunc = ReactEvent.Mouse.t => unit

@module("react-flow-renderer") @react.component
external make: (
  ~elements: elements<'a>,
  ~children: React.element=?,
  ~onElementsClick: (~event: Dom.mouseEvent=?, ~element: flowElement<'a>=?) => unit=?,
  ~snapToGrid: bool=?,
  ~onConnect: outsiderEdge => unit=?,
  ~onElementsRemove: array<outsiderElement> => unit=?,
  ~onLoad: onLoadParams<'a> => unit=?,
  ~snapGrid: (int, int)=?,
  ~nodeTypes: 'a=?,
  ~selectNodesOnDrag: bool=?,
  ~className: string=?,
  ~onConnectStart: onConnectStartFunc=?,
  ~onConnectStop: onConnectStopFunc=?,
  ~onConnectEnd: onConnectEndFunc=?,
) => React.element = "default"

let getIdFromElem = (elem: flowElement<'a>) => {
  switch elem {
  | Edge(elem) => Edge.idGet(elem)
  | Node(elem) => Node.idGet(elem)
  }
}

let removeElements = (elemsToRemove: array<outsiderElement>, elems: elements<'a>): elements<'a> => {
  let idsToRemove = Js.Array.map(x => x.id, elemsToRemove)

  let shouldRemoveId = id => !Js.Array.includes(id, idsToRemove)

  Js.Array.filter(e => shouldRemoveId(getIdFromElem(e)), elems)
}

let addEdge = (edgeToAdd: outsiderEdge, elems: elements<'a>) => {
  Js.Array.concat(
    [
      Edge(
        Edge.makeEdge(
          ~id=`reactflow__edge-${edgeToAdd.source}${Belt.Option.getWithDefault(
              edgeToAdd.sourceHandle,
              "",
            )}-${edgeToAdd.target}${Belt.Option.getWithDefault(edgeToAdd.targetHandle, "")}`,
          ~target=edgeToAdd.target,
          ~source=edgeToAdd.source,
          (),
        ),
      ),
    ],
    elems,
  )
}

module Handle = {
  type handleType = [#source | #target]

  type onConnectFunc = connection => unit

  type isValidConnectionFunc = connection => bool

  @module("react-flow-renderer") @react.component
  external make: (
    @as("type") ~_type: handleType,
    ~position: position,
    ~isConnectable: bool=?,
    ~onConnect: onConnectFunc=?,
    ~isValidConnection: connection => bool=?,
    ~id: elementId=?,
    ~className: string=?,
    ~style: ReactDOM.Style.t=?,
    ~children: React.element=?,
  ) => React.element = "Handle"
}
