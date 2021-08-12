@react.component
let make = (~selectedTodo: Todo.todo) => {
  <div>
    <a href="/"> {React.string("Home")} </a>
    {React.string("Todo Details Page " ++ selectedTodo.text ++ selectedTodo.id)}
  </div>
}
