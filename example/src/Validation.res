%%raw(`import "./validation.css"`)

let elements = [
  ReactFlow.Node(ReactFlow.node(~id="0", ~type_="custominput", ~position={x: 0, y: 150}, ())),
  ReactFlow.Node(ReactFlow.node(~id="A", ~type_="customnode", ~position={x: 250, y: 0}, ())),
  ReactFlow.Node(ReactFlow.node(~id="B", ~type_="customnode", ~position={x: 250, y: 150}, ())),
  ReactFlow.Node(
    ReactFlow.node(~id="C", ~type_="customnode", ~position={x: 250, y: 300}, ~data=2, ()),
  ),
]

let isValidConnection = (connection: ReactFlow.connection) => {
  Js.log("entrou")
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
      <ReactFlow.Handle id="T" type_=#source position=#right isValidConnection />
    </>
  }
}

module CustomNode = {
  @react.component
  let make = (~id) => {
    <>
      <ReactFlow.Handle id="W" type_=#target position=#left isValidConnection />
      <div> {React.string(id)} </div>
      <ReactFlow.Handle id="Y" type_=#target position=#right isValidConnection />
    </>
  }
}

let nodeTypes = {
  "custominput": CustomInput.make,
  "customnode": CustomNode.make,
}

let onLoad = (reactFlowInstance: ReactFlow.onLoadParams<'a>) => {
  reactFlowInstance.fitView({padding: None, includeHiddenNodes: None})
}

@react.component
let make = () => {
  let (elems, setElems) = React.useState(() => elements)
  let onConnect = params => {
    Js.log(params)
    setElems(els => ReactFlow.addEdge(params, els))
  }

  <div className="App" style={ReactDOM.Style.make(~height="800px", ~width="1200px", ())}>
    <ReactFlow
      elements={elems->ReactFlow.convertElemsToJs}
      onConnect
      selectNodesOnDrag=false
      onLoad
      className="validationflow"
      nodeTypes
    />
  </div>
}
