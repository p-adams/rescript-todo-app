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
  text: "",
}
@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  let (todoText, setTodoText) = React.useState(_ => "")
  let (todoList, setTodoList) = React.useState(_ => todos)
  let (toggleSelectAll, setToggleSelectAll) = React.useState(_ => false)
  let (editMode, setEditMode) = React.useState(_ => editState)

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

  let onCheckAll = _ => {
    // TODO: implement check all
    setToggleSelectAll(_prev => !toggleSelectAll)
    setTodoList(_prev =>
      Js.Array2.map(todoList, todo => {
        {
          ...todo,
          checked: !toggleSelectAll,
        }
      })
    )
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
    setEditMode(_prev => {id: id, isEditing: !editMode.isEditing, text: text})
  }

  let onEdit = e => {
    ReactEvent.Form.preventDefault(e)
    let v = ReactEvent.Form.target(e)["value"]
    setEditMode(prev => {...prev, text: v})
  }

  let cancelEdit = () => {
    setEditMode(_prev => {id: "", isEditing: false, text: ""})
  }

  let saveEdit = () => {
    let updatedTodos = Js.Array2.map(todoList, todo => {
      if todo.id === editMode.id {
        {
          ...todo,
          text: editMode.text !== "" ? editMode.text : todo.text,
        }
      } else {
        todo
      }
    })
    setTodoList(_prev => updatedTodos)
    setEditMode(_prev => {id: "", isEditing: false, text: ""})
  }

  let markSelectedTodos = () => {
    let updatedTodos = Js.Array2.map(todoList, todo => {
      if todo.checked {
        {
          ...todo,
          completed: !todo.completed,
        }
      } else {
        todo
      }
    })
    setTodoList(_prev => updatedTodos)
  }

  let cancelMarkSelected = () => {
    setTodoList(_prev =>
      Js.Array2.map(todoList, todo => {
        if todo.checked {
          {
            ...todo,
            checked: false,
            completed: false,
          }
        } else {
          todo
        }
      })
    )
  }

  <>
    <nav>
      <img src={"/favicon.ico"} alt="todo" />
      <div className="link-container">
        <a href="javascript:;" onClick={_ => RescriptReactRouter.push("/")}>
          {React.string("Home")}
        </a>
      </div>
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
        cancelEdit
        saveEdit
        markSelectedTodos
        cancelMarkSelected
      />
    | _ => <NotFound />
    }}
  </>
}
