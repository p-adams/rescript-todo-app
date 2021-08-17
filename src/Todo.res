type todo = {
  id: string,
  text: string,
  completed: bool,
  checked: bool,
  created_at: string,
}

type editMode = {
  id: string,
  isEditing: bool,
}

module Todo = {
  type t = todo
  type e = editMode
}
