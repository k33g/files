## jsonToDynamicObject

## What

`jsonToDynamicObject.golo` module provides helper functions to transform complex JSON string to DynamicObject
- install module: `curl -O https://raw.githubusercontent.com/k33g/files/master/snippets/golo/json/jsonToDynamicObject.golo`
- install sample: `curl -O https://raw.githubusercontent.com/k33g/files/master/snippets/golo/json/sample.golo`

## Why

`JSON.toDynamicObject` of `gololang.JSON` module doesn't work with complex JSON objects (https://github.com/eclipse/golo-lang/blob/master/src/main/golo/json.golo#L119)

## How to

```golo
let bob = """{
  "id": "bob_morane", "firstName": "Bob", "lastName": "Morane",
  "friends": [
    {"firstname":"John", "lastname":"Doe"},
    {"firstname":"Jane", "lastname":"Doe"}
  ]
}"""

let dyno = toDynamicObjectTreeFromString(bob)

  println(dyno: id())
  println(dyno: firstName()+ " " + dyno: lastName())
  dyno: friends(): each(|friend| -> println(friend: firstName())
```


