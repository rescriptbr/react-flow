

import * as Belt_Array from "bs-platform/lib/es6/belt_Array.js";

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
                _0: {
                  id: "e" + edgeToAdd.source + "-" + edgeToAdd.target,
                  source: edgeToAdd.source,
                  target: edgeToAdd.target
                },
                [Symbol.for("name")]: "Edge"
              }]);
}

var Handle = {};

export {
  unwrap ,
  convertElemsToJs ,
  getIdFromElem ,
  removeElements ,
  addEdge ,
  Handle ,
  
}
/* No side effect */
