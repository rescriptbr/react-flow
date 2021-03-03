%%raw(`import './App.css'`)

@module("./logo.svg")
external logo: string = "default"

let elements = [
  ReactFlow.Node(
    ReactFlow.node(
      ~id="1",
      ~position={x: 250, y: 0},
      ~data={"label": React.string("test")},
      ~type_="input",
      (),
    ),
  ),
  ReactFlow.Node(
    ReactFlow.node(~id="2", ~position={x: 100, y: 100}, ~data={"label": React.string("test2")}, ()),
  ),
  ReactFlow.Node(
    ReactFlow.node(
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
  ReactFlow.Edge(
    ReactFlow.edge(~id="e1-2", ~source="1", ~target="2", ~label="this is an edge label", ()),
  ),
]

let onLoad = (reactFlowInstance: ReactFlow.onLoadParams<'a>) => {
  Js.log2("flow loaded: ", reactFlowInstance)
}

@react.component
let make = () => {
  let (elems, setElems) = React.useState(() => elements)
  let onElementsRemove = elementsToRemove => {
    setElems(elems => ReactFlow.removeElements(elementsToRemove, elems))
  }

  let onConnect = params => {
    setElems(elems => ReactFlow.addEdge(params, elems))
  }

  <div className="App" style={ReactDOM.Style.make(~height="800px", ~width="1200px", ())}>
    <ReactFlow
      elements={elems->ReactFlow.convertElemsToJs}
      onElementsRemove
      onConnect
      onLoad
      snapToGrid=true
      snapGrid=(15, 15)
    />
  </div>
}
