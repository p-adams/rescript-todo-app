@send external focus: Dom.element => unit = "focus"
@react.component
let make = (
  ~todoList,
  ~todoText: string,
  ~onChange,
  ~addTodo,
  ~toggleDone,
  ~onCheck,
  ~checkedTodoCount,
  ~onCheckAll,
  ~toggleSelectAll,
  ~deleteTodo,
  ~editTodo,
  ~editMode: Todo.editMode,
  ~onEdit,
  ~cancelEdit,
  ~saveEdit,
  ~markSelectedTodos,
  ~cancelMarkSelected,
  ~deletedSelectedTodos,
) => {
  let textInput = React.useRef(Js.Nullable.null)
  let editTextInput = React.useRef(Js.Nullable.null)

  let focusInput = () =>
    switch textInput.current->Js.Nullable.toOption {
    | Some(dom) => dom->focus
    | None => ()
    }

  React.useEffect(() => {
    focusInput()
    None
  })

  let items = Js.Array2.map(todoList, todo => {
    <TodoItem
      key={todo.id} todo={todo} toggleDone onCheck deleteTodo editTodo editMode toggleSelectAll
    />
  })
  let hasCheckedTodos = checkedTodoCount() > 0
  let hasCompletedTodos = Js.Array2.some(todoList, todo => {
    todo.checked && todo.completed
  })

  let todoToEdit = Js.Array2.find(todoList, todo => {
    todo.id === editMode.id
  })

  <div className="todo-list-container">
    <main className={hasCheckedTodos ? "selected-border" : ""}>
      <div className="todo-header">
        <label>
          <input type_="checkbox" onChange={e => onCheckAll(e)} checked={toggleSelectAll} />
          <span> {React.string(!toggleSelectAll ? "Select All" : "Deselect All")} </span>
        </label>
        <div className={`checked-count ${hasCheckedTodos ? "fadein" : "fadeout"}`}>
          {React.int(checkedTodoCount())}
        </div>
      </div>
      <ul> {React.array(items)} </ul>
      <div className="actions-in-app">
        {switch todoToEdit {
        | None => <>
            <input
              ref={ReactDOM.Ref.domRef(textInput)}
              placeholder="enter text"
              onChange
              value={todoText}
            />
            <button className="dark" onClick={_ => addTodo()}> {React.string("Add")} </button>
          </>
        | Some(_) => <>
            <input
              ref={ReactDOM.Ref.domRef(editTextInput)}
              onChange={e => onEdit(e)}
              value={editMode.text}
            />
            <button className="dark" onClick={_ => cancelEdit()}> {React.string("Cancel")} </button>
            <button className="dark" onClick={_ => saveEdit()}> {React.string("Save")} </button>
          </>
        }}
      </div>
      <div className={`bulk-select-action-bar ${hasCheckedTodos ? "fadein" : "fadeout"}`}>
        <label onClick={_ => markSelectedTodos()}>
          {React.string(!hasCompletedTodos ? "mark as complete" : "mark as incomplete")}
          <span className="icon fas fa-check" />
        </label>
        <label onClick={_ => deletedSelectedTodos()}>
          {React.string("delete")} <span className="icon fas fa-trash" />
        </label>
        <button className="light" onClick={_ => cancelMarkSelected()}>
          {React.string("Cancel")}
        </button>
      </div>
    </main>
  </div>
}
