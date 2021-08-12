@react.component
let make = (~id: string) => {
  <div> {React.string("Todo Details Page " ++ id)} </div>
}
