@react.component
let make = (~todo: Todo.todo, ~onSelect) => {
  <li className="todo-item" onClick={_ => onSelect(todo.id)}> {React.string(todo.text)} </li>
}
