@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  switch url.path {
  | list{"details", id} => <TodoDetails id />
  | list{} => <TodoList />
  | _ => <NotFound />
  }
}
