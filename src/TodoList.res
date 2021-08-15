@react.component
let make = (
  ~todoList,
  ~todoText: string,
  ~onChange,
  ~addTodo,
  ~toggleDone,
  ~onCheck,
  ~checkedTodoCount,
  ~onCheckAll,
  ~toggleSelectAll,
) => {
  let items = Belt.Array.map(todoList, todo => {
    <TodoItem key={todo.id} todo={todo} toggleDone onCheck />
  })
  let hasCheckedTodos = checkedTodoCount() > 0
  <div className="todo-list-container">
    <main className={hasCheckedTodos ? "selected-border" : ""}>
      <div className="todo-header">
        <label>
          <input type_="checkbox" onChange={e => onCheckAll(e)} />
          <span> {React.string(!toggleSelectAll ? "Select All" : "Deselect All")} </span>
        </label>
        <div className={`checked-count ${hasCheckedTodos ? "fadein" : "fadeout"}`}>
          {React.int(checkedTodoCount())}
        </div>
      </div>
      <ul> {React.array(items)} </ul>
      <div className="actions-in-app">
        <input placeholder="enter text" onChange value={todoText} />
        <button className="dark" onClick={_ => addTodo()}> {React.string("Add")} </button>
      </div>
      <div className={`bulk-select-action-bar ${hasCheckedTodos ? "fadein" : "fadeout"}`}>
        <label> {React.string("mark as complete")} <span className="icon fas fa-check" /> </label>
        <label> {React.string("delete")} <span className="icon fas fa-trash" /> </label>
        <button className="light"> {React.string("Cancel")} </button>
      </div>
    </main>
  </div>
}
