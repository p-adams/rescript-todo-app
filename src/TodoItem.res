@react.component
let make = (
  ~todo: Todo.todo,
  ~toggleDone,
  ~onCheck,
  ~deleteTodo,
  ~editTodo,
  ~editMode: Todo.editMode,
  ~toggleSelectAll,
) => {
  <li className="todo-item">
    <input
      type_="checkbox" onChange={e => onCheck(e, todo.id)} checked={todo.checked || toggleSelectAll}
    />
    <a
      href="#"
      onClick={_ => RescriptReactRouter.push(`/details/${todo.id}`)}
      className={`todo-text ${todo.completed ? "completed" : ""}`}>
      {React.string(todo.text)}
    </a>
    <span
      className={`icon ${todo.completed ? "completed" : ""} fas fa-check`}
      onClick={_ => toggleDone(todo.id)}
    />
    <span
      className={`icon ${editMode.id === todo.id ? "editing" : ""} fas fa-edit`}
      onClick={_ => editTodo(todo.id, todo.text)}
    />
    <span className="icon fas fa-trash" onClick={_ => deleteTodo(todo.id)} />
  </li>
}
