

import * as Belt_Array from "bs-platform/lib/es6/belt_Array.js";

function unwrap(elem) {
  return elem._0;
}

function convertElemsToJs(elems) {
  return Belt_Array.map(elems, unwrap);
}

export {
  unwrap ,
  convertElemsToJs ,
  
}
/* No side effect */
