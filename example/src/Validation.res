%%raw(`import "./validation.css"`)

let elements = [
  ReactFlow.Types.Node(
    ReactFlow.Node.makeNode(~id="0", ~type_="custominput", ~position={x: 0, y: 150}, ()),
  ),
  ReactFlow.Types.Node(
    ReactFlow.Node.makeNode(~id="A", ~type_="customnode", ~position={x: 250, y: 0}, ()),
  ),
  ReactFlow.Types.Node(
    ReactFlow.Node.makeNode(~id="B", ~type_="customnode", ~position={x: 250, y: 150}, ()),
  ),
  ReactFlow.Types.Node(
    ReactFlow.Node.makeNode(~id="C", ~type_="customnode", ~position={x: 250, y: 300}, ()),
  ),
]

let isValidConnection = (connection: ReactFlow.Types.connection) => {
  Belt.Option.getExn(connection.target) === "B"
}

let onConnectStop = event => Js.log(event)
let onConnectStart = (event, params) => Js.log2(event, params)
let onConnectEnd = event => Js.log2("end: ", event)

module CustomInput = {
  @react.component
  let make = () => {
    <>
      <div> {React.string("Only connectable with B")} </div>
      <ReactFlow.Handle id="T" _type=#source position=#right isValidConnection />
    </>
  }
}

module CustomNode = {
  @react.component
  let make = (~id) => {
    <>
      <ReactFlow.Handle id="W" _type=#target position=#left isValidConnection />
      <div> {React.string(id)} </div>
      <ReactFlow.Handle id="Y" _type=#target position=#right isValidConnection />
    </>
  }
}

let nodeTypes = {
  "custominput": CustomInput.make,
  "customnode": CustomNode.make,
}

let onLoad = (reactFlowInstance: ReactFlow.Types.onLoadParams) => {
  reactFlowInstance.fitView({padding: None, includeHiddenNodes: None})
}

@react.component
let make = () => {
  let (elems, setElems) = React.useState(() => elements)
  let onConnect = params => {
    setElems(elems => ReactFlow.Utils.addEdge(~elemToAdd=params, ~elems))
  }

  <div className="App" style={ReactDOM.Style.make(~height="800px", ~width="1200px", ())}>
    <ReactFlow
      elements={elems->ReactFlow.Utils.elementsToRaw}
      onConnect
      onConnectEnd
      onConnectStart
      onConnectStop
      selectNodesOnDrag=false
      onLoad
      className="validationflow"
      nodeTypes
    />
  </div>
}
