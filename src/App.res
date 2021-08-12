%%raw("import '../style.css'")
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
  let (selectedTodo, setSelectedTodo) = React.useState(_ => todoList[0])
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

  let onSelect = (id: string) => {
    let todo = Js.Array2.filter(todoList, todo => {
      todo.id === id
    })

    setSelectedTodo(_prev => todo[0])
    RescriptReactRouter.push("/details/")
  }

  switch url.path {
  | list{"details"} => <TodoDetails selectedTodo />
  | list{} => <TodoList todoList todoText addTodo onChange onSelect />
  | _ => <NotFound />
  }
}
