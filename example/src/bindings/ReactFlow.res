type elementId = string

type transform = (int, int, int)

type position = [#Left | #Top | #Right | #Bottom]

type arrowHeadType = [#Arrow | #ArrowClosed]

type xyPosition = {x: int, y: int}

type dimensions = {
  width: int,
  height: int,
}

@deriving({abstract: light})
type node<'a> = {
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

@deriving(abstract)
type edge<'a> = {
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

@deriving({abstract: light})
type connection = {
  @optional
  source: elementId,
  @optional
  target: elementId,
  @optional
  sourceHandle: elementId,
  @optional
  targetHandle: elementId,
}

type edgeOrConnection<'a> = Connection(connection) | Edge(edge<'a>)

type flowElement<'a> = Node(node<'a>) | Edge(edge<'a>)

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

type fitViewFunc = (~fitViewOptions: fitViewParams=?) => unit

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
) => React.element = "default"

let getIdFromElem = (elem: flowElement<'a>) => {
  switch elem {
  | Edge(elem) => idGet(elem)
  | Node(elem) => id(elem)
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
        edge(
          ~id=`e${edgeToAdd.source}-${edgeToAdd.target}`,
          ~target=edgeToAdd.target,
          ~source=edgeToAdd.source,
          (),
        ),
      ),
    ],
    elems,
  )
}
