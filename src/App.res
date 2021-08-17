let todos: array<Todo.todo> = [
  {
    id: "001",
    text: "Learn Rescript",
    completed: false,
    checked: false,
    created_at: Js.Date.toLocaleString(Js.Date.make()),
  },
  {
    id: "002",
    text: "Learn Ocaml",
    completed: false,
    checked: false,
    created_at: Js.Date.toLocaleString(Js.Date.make()),
  },
  {
    id: "003",
    text: "Learn FP",
    completed: false,
    checked: false,
    created_at: Js.Date.toLocaleString(Js.Date.make()),
  },
]

let editState: Todo.editMode = {
  id: "",
  isEditing: false,
}
@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  let (todoText, setTodoText) = React.useState(_ => "")
  let (todoList, setTodoList) = React.useState(_ => todos)
  let (toggleSelectAll, setToggleSelectAll) = React.useState(_ => false)
  let (editMode, setEditMode) = React.useState(_ => editState)
  let (editText, setEditText) = React.useState(_ => "")

  let onChange = e => {
    ReactEvent.Form.preventDefault(e)
    let v = ReactEvent.Form.target(e)["value"]
    setTodoText(_prev => v)
  }
  let addTodo = () => {
    if todoText !== "" {
      let id = ReScriptHash.Sha1.make(todoText)
      setTodoList(_prev =>
        Js.Array2.concat(
          todoList,
          [
            {
              id: id,
              text: todoText,
              completed: false,
              checked: false,
              created_at: Js.Date.toLocaleString(Js.Date.make()),
            },
          ],
        )
      )
      setTodoText(_p => "")
    }
  }
  let toggleDone = (id: string) => {
    let updatedTodoList = Js.Array2.map(todoList, todo => {
      if todo.id === id {
        {
          ...todo,
          completed: !todo.completed,
        }
      } else {
        todo
      }
    })

    setTodoList(_p => updatedTodoList)
  }

  let onCheck = (e, id: string) => {
    let isChecked = ReactEvent.Form.target(e)["checked"]

    let checkedTodoList = Js.Array2.map(todoList, todo => {
      if todo.id === id {
        {
          ...todo,
          checked: isChecked,
        }
      } else {
        todo
      }
    })
    setTodoList(_prev => checkedTodoList)
  }

  let onCheckAll = e => {
    // TODO: implement check all
    setToggleSelectAll(_prev => !toggleSelectAll)
    Js.log(e)
  }

  let checkedTodoCount = () => {
    Js.Array2.length(Js.Array2.filter(todoList, todo => todo.checked))
  }

  let deleteTodo = (id: string) => {
    let updatedTodos = Js.Array2.filter(todoList, todo => {
      todo.id !== id
    })
    setTodoList(_prev => updatedTodos)
  }

  let editTodo = (id: string, text: string) => {
    // TODO: implement edit todo
    setEditMode(_prev => {id: id, isEditing: !editMode.isEditing})
    setEditText(_prev => text)
  }

  let onEdit = e => {
    ReactEvent.Form.preventDefault(e)
    let v = ReactEvent.Form.target(e)["value"]
    setEditText(_prev => v)
  }

  <>
    <nav>
      <img src={"/favicon.ico"} alt="todo" />
      <div className="link-container"> <a href="/"> {React.string("Home")} </a> </div>
    </nav>
    {switch url.path {
    | list{"details", id} => <TodoDetails id todoList />
    | list{} =>
      <TodoList
        todoList
        todoText
        addTodo
        onChange
        toggleDone
        onCheck
        checkedTodoCount
        onCheckAll
        toggleSelectAll
        deleteTodo
        editTodo
        editMode
        onEdit
        editText
      />
    | _ => <NotFound />
    }}
  </>
}
