@react.component
let make = (~id, ~todoList: array<Todo.todo>) => {
  let selectedTodo2 = Js.Array2.find(todoList, todo => {
    todo.id === id
  })
  let timer = ref(Js.Nullable.null)
  let redirectHome = () => RescriptReactRouter.push("/")
  if selectedTodo2 == None {
    Js.Nullable.iter(timer.contents, (. timer) => Js.Global.clearTimeout(timer))
    timer := Js.Nullable.return(Js.Global.setTimeout(() => redirectHome(), 3000))
  }
  switch selectedTodo2 {
  | None => <div> {React.string("Todo cannot be found. Redirecting...")} </div>
  | Some(todo) =>
    <div className="todo-details">
      <div className="field">
        <span className="label"> <S str="ID" /> </span> <p className="id"> <S str={todo.id} /> </p>
      </div>
      <div className="field">
        <span className="label"> <S str="TODO" /> </span> <p> <S str={todo.text} /> </p>
      </div>
      <div className="field">
        <span className="label"> <S str="CREATED AT" /> </span> <p> <S str={todo.created_at} /> </p>
      </div>
    </div>
  }
}
