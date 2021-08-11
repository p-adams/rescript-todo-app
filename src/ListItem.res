@react.component
let make = (~todo: Todo.todo) => {
  <li className="todo-item"> {React.string(todo.text)} </li>
}
