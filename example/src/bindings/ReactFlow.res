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
    ~nodeColor: Types.MiniMap.t=?,
    ~nodeStrokeColor: Types.MiniMap.t=?,
    ~nodeClassName: Types.MiniMap.t=?,
    ~nodeBorderRadius: float=?,
    ~nodeStrokeWidth: float=?,
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
    ~gap: float=?,
    ~color: string=?,
    ~size: float=?,
  ) => React.element = "Background"
}
