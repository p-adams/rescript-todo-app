@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()
  let todos: array<Todo.todo> = [
    {id: "001", text: "Learn Rescript", completed: false, checked: false},
    {id: "002", text: "Learn Ocaml", completed: false, checked: false},
    {id: "003", text: "Learn FP", completed: false, checked: false},
  ]
  let (todoText, setTodoText) = React.useState(_ => "")
  let (todoList, setTodoList) = React.useState(_ => todos)
  let (toggleSelectAll, setToggleSelectAll) = React.useState(_ => false)

  let onChange = e => {
    ReactEvent.Form.preventDefault(e)
    let v = ReactEvent.Form.target(e)["value"]
    setTodoText(_prev => v)
  }
  let addTodo = () => {
    if todoText !== "" {
      let id = ReScriptHash.Sha1.make(todoText)
      setTodoList(_prev =>
        Js.Array2.concat(todoList, [{id: id, text: todoText, completed: false, checked: false}])
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

  let onSelect = (id: string) => {
    let todo = Js.Array2.filter(todoList, todo => {
      todo.id === id
    })

    RescriptReactRouter.push("/details/" ++ todo[0].id)
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

  <>
    <nav> <a href="/"> {React.string("Home")} </a> </nav>
    {switch url.path {
    | list{"details", id} => <TodoDetails id todoList />
    | list{} =>
      <TodoList
        todoList
        todoText
        addTodo
        onChange
        onSelect
        toggleDone
        onCheck
        checkedTodoCount
        onCheckAll
        toggleSelectAll
      />
    | _ => <NotFound />
    }}
  </>
}
