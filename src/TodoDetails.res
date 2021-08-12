@react.component
let make = (~selectedTodo: Todo.todo) => {
  <div> {React.string("Todo Details Page " ++ selectedTodo.text)} </div>
}
