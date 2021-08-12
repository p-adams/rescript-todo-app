@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()
  let todos: array<Todo.todo> = [
    {id: "001", text: "Learn Rescript", completed: false},
    {id: "002", text: "Learn Ocaml", completed: false},
    {id: "003", text: "Learn FP", completed: false},
  ]
  let (todoText, setTodoText) = React.useState(_ => "")
  let (todoList, setTodoList) = React.useState(_ => todos)
  let onChange = e => {
    ReactEvent.Form.preventDefault(e)
    let v = ReactEvent.Form.target(e)["value"]
    setTodoText(_prev => v)
  }
  let addTodo = () => {
    let id = ReScriptHash.Sha1.make(todoText)
    setTodoList(_prev => Js.Array2.concat(todoList, [{id: id, text: todoText, completed: false}]))
    setTodoText(_p => "")
  }

  switch url.path {
  | list{"details", id} => <TodoDetails id />
  | list{} => <TodoList todoList todoText addTodo onChange />
  | _ => <NotFound />
  }
}
