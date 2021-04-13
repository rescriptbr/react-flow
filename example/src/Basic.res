let elements = [
  ReactFlow.Types.Node(
    ReactFlow.Node.makeNode(
      ~id="1",
      ~position={x: 250, y: 0},
      ~data={"label": React.string("test")},
      ~type_="input",
      (),
    ),
  ),
  ReactFlow.Types.Node(
    ReactFlow.Node.makeNode(
      ~id="2",
      ~position={x: 100, y: 100},
      ~data={"label": React.string("test2")},
      (),
    ),
  ),
  ReactFlow.Types.Node(
    ReactFlow.Node.makeNode(
      ~id="3",
      ~data={"label": React.string("teste3")},
      ~position={x: 400, y: 100},
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
      (),
    ),
  ),
]

let onLoad = (reactFlowInstance: ReactFlow.Types.onLoadParams<'a>) => {
  reactFlowInstance.fitView({padding: None, includeHiddenNodes: None})
}

@react.component
let make = () => {
  let (elems, setElems) = React.useState(() => elements)
  let onElementsRemove = elementsToRemove => {
    setElems(elems =>
      ReactFlow_Utils.rawToElements(
        ReactFlow_Utils.removeElements(~elemsToRemove=elementsToRemove, ~elems),
      )
    )
  }

  let onConnect = params => {
    setElems(elems =>
      ReactFlow_Utils.rawToElements(ReactFlow_Utils.addEdge(~elemToAdd=params, ~elems))
    )
  }

  <div className="App" style={ReactDOM.Style.make(~height="800px", ~width="1200px", ())}>
    <ReactFlow
      elements={elems->ReactFlow.Utils.elementsToRaw}
      onElementsRemove
      onConnect
      onLoad
      snapToGrid=true
      snapGrid=(15, 15)
    />
  </div>
}
