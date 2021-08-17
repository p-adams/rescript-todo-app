type todo = {
  id: string,
  text: string,
  completed: bool,
  checked: bool,
  created_at: string,
}

module Todo = {
  type t = todo
}
