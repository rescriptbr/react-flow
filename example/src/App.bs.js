

import * as Curry from "bs-platform/lib/es6/curry.js";
import * as React from "react";
import LogoSvg from "./logo.svg";
import ReactFlowRenderer from "react-flow-renderer";
import * as ReactFlowRenderer$1 from "react-flow-renderer";
import * as ReactFlow$ReactFlowTest from "./bindings/ReactFlow.bs.js";

import './App.css'
;

var logo = LogoSvg;

var elements = [
  {
    TAG: 0,
    _0: {
      id: "1",
      position: {
        x: 250,
        y: 0
      },
      type: "input",
      data: {
        label: "test"
      }
    },
    [Symbol.for("name")]: "Node"
  },
  {
    TAG: 0,
    _0: {
      id: "2",
      position: {
        x: 100,
        y: 100
      },
      data: {
        label: "test2"
      }
    },
    [Symbol.for("name")]: "Node"
  },
  {
    TAG: 0,
    _0: {
      id: "3",
      position: {
        x: 400,
        y: 100
      },
      data: {
        label: "teste3"
      },
      style: {
        background: "#D6D5E6",
        border: "1px solid #222138",
        color: "#333",
        width: "180"
      }
    },
    [Symbol.for("name")]: "Node"
  }
];

function onLoad(reactFlowInstance) {
  console.log("flow loaded: ", reactFlowInstance);
  
}

function App(Props) {
  var match = React.useState(function () {
        return elements;
      });
  var setElems = match[1];
  var elems = match[0];
  var onElementsRemove = function (elementsToRemove) {
    return Curry._1(setElems, (function (els) {
                  return ReactFlowRenderer$1.removeElements(elementsToRemove, ReactFlow$ReactFlowTest.convertElemsToJs(els));
                }));
  };
  var onConnect = function (params) {
    return Curry._1(setElems, (function (elems) {
                  var a = ReactFlow$ReactFlowTest.convertElemsToJs(elems);
                  return ReactFlowRenderer$1.addEdge(params, a);
                }));
  };
  React.useEffect((function () {
          console.log(elems);
          
        }), [elems]);
  return React.createElement("div", {
              className: "App",
              style: {
                height: "800px",
                width: "1200px"
              }
            }, React.createElement(ReactFlowRenderer, {
                  elements: ReactFlow$ReactFlowTest.convertElemsToJs(elems),
                  snapToGrid: true,
                  onConnect: onConnect,
                  onElementsRemove: onElementsRemove,
                  onLoad: onLoad,
                  snapGrid: [
                    15,
                    15
                  ]
                }));
}

var make = App;

export {
  logo ,
  elements ,
  onLoad ,
  make ,
  
}
/*  Not a pure module */
