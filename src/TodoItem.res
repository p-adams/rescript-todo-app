@react.component
let make = (~todo: Todo.todo, ~onSelect) => {
  <li className="todo-item">
    <input type_="checkbox" />
    <span onClick={_ => onSelect(todo.id)}> {React.string(todo.text)} </span>
    <span className="fas fa-check" />
    <span className="fas fa-edit" />
    <span className="fas fa-trash" />
  </li>
}
