type todo = {
  id: string,
  text: string,
  completed: bool,
}
@react.component
let make = () => {
  let todos = [
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

  let items = Belt.Array.map(todoList, todo => {
    <li key={todo.id} className="todo-item"> {React.string(todo.text)} </li>
  })
  <>
    <h3> {React.string("Todo App")} </h3>
    <ul> {React.array(items)} </ul>
    <div className="actions-in-app">
      <input placeholder="enter text" onChange value={todoText} />
      <button onClick={_ => addTodo()}> {React.string("Add")} </button>
    </div>
  </>
}
