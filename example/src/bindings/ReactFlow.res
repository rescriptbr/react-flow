module Types = ReactFlow_Types

module Utils = ReactFlow_Utils

module Node = Types.Node

module Edge = Types.Edge

@module("react-flow-renderer") @react.component
external make: (
  ~elements: Types.rawElements,
  ~children: React.element=?,
  ~onElementsClick: (~event: Dom.mouseEvent=?, ~element: Types.rawElement=?) => unit=?,
  ~snapToGrid: bool=?,
  ~onConnect: Types.rawElement => unit=?,
  ~onElementsRemove: Types.rawElements => unit=?,
  ~onLoad: Types.onLoadParams => unit=?,
  ~snapGrid: (int, int)=?,
  ~nodeTypes: 'weakNodeType=?,
  ~edgeTypes: 'weakEdgeType=?,
  ~connectionLineComponent: Types.connectionLineComponent=?,
  ~selectNodesOnDrag: bool=?,
  ~className: string=?,
  ~onConnectStart: Types.onConnectStartFunc=?,
  ~onConnectStop: Types.onConnectStopFunc=?,
  ~onConnectEnd: Types.onConnectEndFunc=?,
) => React.element = "default"

module Handle = {
  @module("react-flow-renderer") @react.component
  external make: (
    @as("type") ~_type: Types.Handle.handleType,
    ~position: Types.position,
    ~isConnectable: bool=?,
    ~onConnect: Types.Handle.onConnectFunc=?,
    ~isValidConnection: Types.connection => bool=?,
    ~id: Types.elementId=?,
    ~className: string=?,
    ~style: ReactDOM.Style.t=?,
    ~children: React.element=?,
  ) => React.element = "Handle"
}

module MiniMap = {
  @module("react-flow-renderer") @react.component
  external make: (
    ~nodeColor: Types.MiniMap.stringFunc=?,
    ~nodeStrokeColor: Types.MiniMap.stringFunc=?,
    ~nodeClassName: Types.MiniMap.stringFunc=?,
    ~nodeBorderRadius: int=?,
    ~nodeStrokeWidth: int=?,
    ~maskColor: string=?,
  ) => React.element = "MiniMap"
}

module Controls = {
  @module("react-flow-renderer") @react.component
  external make: (
    ~showZoom: bool=?,
    ~showFitView: bool=?,
    ~showInteractive: bool=?,
    ~fitViewParams: Types.fitViewParams=?,
    ~onZoomIn: unit => unit=?,
    ~onZoomOut: unit => unit=?,
    ~onFitView: unit => unit=?,
    ~onInteractiveChange: (~interactiveStatus: bool) => unit=?,
  ) => React.element = "Controls"
}

module Background = {
  type backgroundVariant = [#lines | #dots]

  @module("react-flow-renderer") @react.component
  external make: (
    ~variant: backgroundVariant=?,
    ~gap: int=?,
    ~color: string=?,
    ~size: int=?,
  ) => React.element = "Background"
}

module Provider = {
  @module("react-flow-renderer") @react.component
  external make: (~children: React.element) => React.element = "ReactFlowProvider"
}

@module("react-flow-renderer")
external useStoredAction: unit => Types.Action.t = "useStoredAction"

@module("react-flow-renderer")
external useStoreState: unit => Types.reactFlowState = "useStoreState"

@module("react-flow-renderer")
external useZoomPanHelper: unit => Types.zoomPanHelperFunctions = "useZoomPanHelper"

@module("react-flow-renderer")
external useUpdateNodeInternals: unit => Types.updateNodeInternals = "useUpdatenodeInternals"

@module("react-flow-renderer")
external getBezierPath: (
  ~sourceX: int,
  ~sourceY: int,
  ~sourcePosition: Types.position=?,
  ~targetX: int,
  ~targetY: int,
  ~targetPosition: Types.position=?,
  ~centerX: int=?,
  ~centerY: int=?,
) => React.element = "getBezierPath"

@module("react-flow-renderer")
external getSmoothStepPath: (
  ~sourceX: int,
  ~sourceY: int,
  ~sourcePosition: Types.position=?,
  ~targetX: int,
  ~targetY: int,
  ~targetPosition: Types.position=?,
  ~borderRadius: int=?,
  ~centerX: int=?,
  ~centerY: int=?,
) => string = "getSmoothStepPath"

@module("react-flow-renderer")
external getMarkerEnd: (~arrowHeadType: Types.arrowHeadType=?, ~markerEndId: string=?) => string =
  "getMarkerEnd"

@module("react-flow-renderer")
external getCenter: (
  ~sourceX: int,
  ~sourceY: int,
  ~targetX: int,
  ~targetY: int,
  ~sourcePosition: Types.position=?,
  ~targetPosition: Types.position=?,
) => (int, int, int, int) = "getCenter"
