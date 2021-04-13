

import * as Belt_Array from "bs-platform/lib/es6/belt_Array.js";
import * as Belt_Option from "bs-platform/lib/es6/belt_Option.js";
import * as Caml_option from "bs-platform/lib/es6/caml_option.js";

function makeNode(prim, prim$1, prim$2, prim$3, prim$4, prim$5, prim$6, prim$7, prim$8, prim$9, prim$10, prim$11, prim$12) {
  var tmp = {
    id: prim,
    position: prim$1
  };
  if (prim$2 !== undefined) {
    tmp.type = Caml_option.valFromOption(prim$2);
  }
  if (prim$3 !== undefined) {
    tmp.data = Caml_option.valFromOption(prim$3);
  }
  if (prim$4 !== undefined) {
    tmp.style = Caml_option.valFromOption(prim$4);
  }
  if (prim$5 !== undefined) {
    tmp.className = Caml_option.valFromOption(prim$5);
  }
  if (prim$6 !== undefined) {
    tmp.targetPosition = Caml_option.valFromOption(prim$6);
  }
  if (prim$7 !== undefined) {
    tmp.sourcePosition = Caml_option.valFromOption(prim$7);
  }
  if (prim$8 !== undefined) {
    tmp.isHidden = Caml_option.valFromOption(prim$8);
  }
  if (prim$9 !== undefined) {
    tmp.draggable = Caml_option.valFromOption(prim$9);
  }
  if (prim$10 !== undefined) {
    tmp.selectable = Caml_option.valFromOption(prim$10);
  }
  if (prim$11 !== undefined) {
    tmp.connectable = Caml_option.valFromOption(prim$11);
  }
  return tmp;
}

var $$Node = {
  makeNode: makeNode
};

function makeEdge(prim, prim$1, prim$2, prim$3, prim$4, prim$5, prim$6, prim$7, prim$8, prim$9, prim$10, prim$11, prim$12, prim$13, prim$14, prim$15, prim$16, prim$17, prim$18) {
  var tmp = {
    id: prim,
    source: prim$1,
    target: prim$2
  };
  if (prim$3 !== undefined) {
    tmp.type = Caml_option.valFromOption(prim$3);
  }
  if (prim$4 !== undefined) {
    tmp.sourceHandle = Caml_option.valFromOption(prim$4);
  }
  if (prim$5 !== undefined) {
    tmp.targetHandle = Caml_option.valFromOption(prim$5);
  }
  if (prim$6 !== undefined) {
    tmp.label = Caml_option.valFromOption(prim$6);
  }
  if (prim$7 !== undefined) {
    tmp.labelStyle = Caml_option.valFromOption(prim$7);
  }
  if (prim$8 !== undefined) {
    tmp.labelShowBg = Caml_option.valFromOption(prim$8);
  }
  if (prim$9 !== undefined) {
    tmp.labelBgStyle = Caml_option.valFromOption(prim$9);
  }
  if (prim$10 !== undefined) {
    tmp.labelBdPadding = Caml_option.valFromOption(prim$10);
  }
  if (prim$11 !== undefined) {
    tmp.labelBgBorderRadius = Caml_option.valFromOption(prim$11);
  }
  if (prim$12 !== undefined) {
    tmp.style = Caml_option.valFromOption(prim$12);
  }
  if (prim$13 !== undefined) {
    tmp.animated = Caml_option.valFromOption(prim$13);
  }
  if (prim$14 !== undefined) {
    tmp.arrowHeadType = Caml_option.valFromOption(prim$14);
  }
  if (prim$15 !== undefined) {
    tmp.isHidden = Caml_option.valFromOption(prim$15);
  }
  if (prim$16 !== undefined) {
    tmp.data = Caml_option.valFromOption(prim$16);
  }
  if (prim$17 !== undefined) {
    tmp.className = Caml_option.valFromOption(prim$17);
  }
  return tmp;
}

var Edge = {
  makeEdge: makeEdge
};

function unwrap(elem) {
  return elem._0;
}

function convertElemsToJs(elems) {
  return Belt_Array.map(elems, unwrap);
}

function getIdFromElem(elem) {
  return elem._0.id;
}

function removeElements(elemsToRemove, elems) {
  var idsToRemove = elemsToRemove.map(function (x) {
        return x.id;
      });
  return elems.filter(function (e) {
              var id = e._0.id;
              return !idsToRemove.includes(id);
            });
}

function addEdge(edgeToAdd, elems) {
  return elems.concat([{
                TAG: 1,
                _0: makeEdge("reactflow__edge-" + edgeToAdd.source + Belt_Option.getWithDefault(edgeToAdd.sourceHandle, "") + "-" + edgeToAdd.target + Belt_Option.getWithDefault(edgeToAdd.targetHandle, ""), edgeToAdd.source, edgeToAdd.target, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined),
                [Symbol.for("name")]: "Edge"
              }]);
}

var Handle = {};

export {
  $$Node ,
  Edge ,
  unwrap ,
  convertElemsToJs ,
  getIdFromElem ,
  removeElements ,
  addEdge ,
  Handle ,
  
}
/* No side effect */
