@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  let selected = switch url.path {
  | list{"Basic"} => <Basic />
  | _ => <Validation />
  }

  <div>
    <NavButton name="Basic" linkTo="Basic" />
    <NavButton name="Validation" linkTo="Validation" />
    {selected}
  </div>
}
