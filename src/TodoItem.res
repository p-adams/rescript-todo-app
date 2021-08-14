@react.component
let make = (~todo: Todo.todo, ~onSelect, ~toggleDone) => {
  <li className="todo-item">
    <input type_="checkbox" />
    <span
      className={`todo-text ${todo.completed ? "completed" : ""}`} onClick={_ => onSelect(todo.id)}>
      {React.string(todo.text)}
    </span>
    <span className="icon fas fa-check" onClick={_ => toggleDone(todo.id)} />
    <span className="icon fas fa-edit" />
    <span className="icon fas fa-trash" />
  </li>
}
