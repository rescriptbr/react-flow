let elements = [
  ReactFlow.Types.Node(
    ReactFlow.Node.makeNode(
      ~id="1",
      ~position={x: 250, y: 0},
      ~data=ReactFlow.Node.toData({"label": React.string("test")}),
      ~type_="input",
      (),
    ),
  ),
  ReactFlow.Types.Node(
    ReactFlow.Node.makeNode(
      ~id="2",
      ~position={x: 100, y: 100},
      ~data=ReactFlow.Node.toData({"label": React.string("test2")}),
      ~type_="output",
      (),
    ),
  ),
  ReactFlow.Types.Node(
    ReactFlow.Node.makeNode(
      ~id="3",
      ~data=ReactFlow.Node.toData({"label": React.string("test3")}),
      ~position={x: 400, y: 100},
      ~type_="default",
      ~style=ReactDOM.Style.make(
        ~color="#333",
        ~background="#D6D5E6",
        ~border="1px solid #222138",
        ~width="180",
        (),
      ),
      (),
    ),
  ),
  ReactFlow.Types.Edge(
    ReactFlow.Edge.makeEdge(
      ~id="e1-2",
      ~source="1",
      ~target="2",
      ~label="this is an edge label",
      ~data=ReactFlow.Edge.toData("some other data"),
      (),
    ),
  ),
]

let onLoad = (reactFlowInstance: ReactFlow.Types.onLoadParams) => {
  reactFlowInstance.fitView({padding: None, includeHiddenNodes: None})
}

@react.component
let make = () => {
  let (elems, setElems) = React.useState(() => elements)
  let onElementsRemove = elementsToRemove => {
    setElems(elems => ReactFlow.Utils.removeElements(elementsToRemove, elems))
  }

  let onConnect = newEdgeParams => {
    setElems(elems => ReactFlow.Utils.addEdge(newEdgeParams, elems))
  }

  <div className="App" style={ReactDOM.Style.make(~height="800px", ~width="1200px", ())}>
    <ReactFlow
      elements={elems->ReactFlow.Utils.elementsToRaw}
      onElementsRemove
      onConnect
      onLoad
      snapToGrid=true
      snapGrid=(15, 15)>
      <ReactFlow.Controls />
      <ReactFlow.Background variant=#lines color="#aaa" gap={16} />
      <ReactFlow.MiniMap
        nodeColor={n => {
          switch ReactFlow.Node.type_Get(n) {
          | Some("input") => "#0041d0"
          | Some("output") => "#ff0072"
          | Some("default") => "#1a192b"
          | _ => "#eee"
          }
        }}
        nodeStrokeColor={_ => "#fff"}
        nodeBorderRadius={2}
      />
    </ReactFlow>
  </div>
}
