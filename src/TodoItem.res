@react.component
let make = (~todo: Todo.todo, ~onSelect) => {
  <li className="todo-item">
    <input type_="checkbox" />
    <span className="todo-text" onClick={_ => onSelect(todo.id)}> {React.string(todo.text)} </span>
    <span className="icon fas fa-check" />
    <span className="icon fas fa-edit" />
    <span className="icon fas fa-trash" />
  </li>
}
