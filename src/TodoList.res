@react.component
let make = (
  ~todoList,
  ~todoText: string,
  ~onChange,
  ~addTodo,
  ~onSelect,
  ~toggleDone,
  ~onCheck,
  ~checkedTodoCount,
) => {
  let items = Belt.Array.map(todoList, todo => {
    <TodoItem key={todo.id} todo={todo} onSelect toggleDone onCheck />
  })
  <div className="todo-list-container">
    <h3> {React.string("Todo App")} </h3>
    <div className={`bulk-select-action-bar ${checkedTodoCount() > 0 ? "fadein" : "fadeout"}`}>
      <div className="checked-count"> {React.int(checkedTodoCount())} </div>
      <label> {React.string("mark as complete")} <span className="icon fas fa-check" /> </label>
      <label> {React.string("delete")} <span className="icon fas fa-trash" /> </label>
    </div>
    <ul> {React.array(items)} </ul>
    <div className="actions-in-app">
      <input placeholder="enter text" onChange value={todoText} />
      <button onClick={_ => addTodo()}> {React.string("Add")} </button>
    </div>
  </div>
}
