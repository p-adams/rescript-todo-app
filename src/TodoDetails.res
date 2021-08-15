@react.component
let make = (~id, ~todoList: array<Todo.todo>) => {
  let selectedTodo2 = Js.Array2.find(todoList, todo => {
    todo.id === id
  })
  let timer = ref(Js.Nullable.null)
  let redirectHome = () => RescriptReactRouter.push("/")
  if selectedTodo2 == None {
    Js.Nullable.iter(timer.contents, (. timer) => Js.Global.clearTimeout(timer))
    timer := Js.Nullable.return(Js.Global.setTimeout(() => redirectHome(), 3000))
  }
  switch selectedTodo2 {
  | None => <div> {React.string("Todo cannot be found. Redirecting...")} </div>
  | Some(todo) => <div> {React.string("Todo Details Page " ++ todo.text)} </div>
  }
}
