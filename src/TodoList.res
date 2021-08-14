@react.component
let make = (~todoList, ~todoText: string, ~onChange, ~addTodo, ~onSelect, ~toggleDone) => {
  let items = Belt.Array.map(todoList, todo => {
    <TodoItem key={todo.id} todo={todo} onSelect toggleDone />
  })
  <div className="todo-list-container">
    <h3> {React.string("Todo App")} </h3>
    <ul> {React.array(items)} </ul>
    <div className="actions-in-app">
      <input placeholder="enter text" onChange value={todoText} />
      <button onClick={_ => addTodo()}> {React.string("Add")} </button>
    </div>
  </div>
}
