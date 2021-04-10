@react.component
let make = (~name: string, ~linkTo: string) => {
  let url = RescriptReactRouter.useUrl()
  let path = List.length(url.path) > 0 ? List.hd(url.path) : ""
  let style = if path == name {
    ReactDOM.Style.make(~backgroundColor="#656565", ~padding="1ex", ~color="#fff", ())
  } else {
    ReactDOM.Style.make(~backgroundColor="#efefef", ~padding="1ex", ())
  }

  <a style={style} href={`/${linkTo}`}> {React.string(name)} </a>
}
