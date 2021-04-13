module Types = ReactFlow_Types

module Utils = ReactFlow_Utils

module Node = Types.Node

module Edge = Types.Edge

@module("react-flow-renderer") @react.component
external make: (
  ~elements: Types.rawElements,
  ~children: React.element=?,
  ~onElementsClick: (~event: Dom.mouseEvent=?, ~element: Types.flowElement<'a>=?) => unit=?,
  ~snapToGrid: bool=?,
  ~onConnect: Types.rawElement => unit=?,
  ~onElementsRemove: Types.rawElements => unit=?,
  ~onLoad: Types.onLoadParams<'a> => unit=?,
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
