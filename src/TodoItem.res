@react.component
let make = (~todo: Todo.todo, ~toggleDone, ~onCheck) => {
  <li className="todo-item">
    <input type_="checkbox" onChange={e => onCheck(e, todo.id)} />
    <a href={`/details/${todo.id}`} className={`todo-text ${todo.completed ? "completed" : ""}`}>
      {React.string(todo.text)}
    </a>
    <span className="icon fas fa-check" onClick={_ => toggleDone(todo.id)} />
    <span className="icon fas fa-edit" />
    <span className="icon fas fa-trash" />
  </li>
}
