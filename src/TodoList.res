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
  ~onCheckAll,
  ~toggleSelectAll,
) => {
  let items = Belt.Array.map(todoList, todo => {
    <TodoItem key={todo.id} todo={todo} onSelect toggleDone onCheck />
  })
  <div className="todo-list-container">
    <h3> {React.string("Todo App")} </h3>
    <div className="todo-header">
      <label>
        <input type_="checkbox" onChange={e => onCheckAll(e)} />
        <span> {React.string(!toggleSelectAll ? "Select All" : "Deselect All")} </span>
      </label>
    </div>
    <ul> {React.array(items)} </ul>
    <div className="actions-in-app">
      <input placeholder="enter text" onChange value={todoText} />
      <button className="dark" onClick={_ => addTodo()}> {React.string("Add")} </button>
    </div>
    <div className={`bulk-select-action-bar ${checkedTodoCount() > 0 ? "fadein" : "fadeout"}`}>
      <div className="checked-count"> {React.int(checkedTodoCount())} </div>
      <label> {React.string("mark as complete")} <span className="icon fas fa-check" /> </label>
      <label> {React.string("delete")} <span className="icon fas fa-trash" /> </label>
      <button className="light"> {React.string("Cancel")} </button>
    </div>
  </div>
}
