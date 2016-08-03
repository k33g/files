module sample_json

import jsonToDynamicObject

function main = |args| {
  let bob = """
  {
    "id": "bob_morane", "firstName": "Bob", "lastName": "Morane",
    "things": {
      "id": "001",
      "message": {
        "text": "this is a box"
      },
      "bidules": [
        42,
        "42",
        {
          "trucs":[
            1,
            2,
            3,
            {
              "tools": [
                "hammer",
                "fork",
                "knife",
                {
                  "yo":"HELLO"
                }
              ]
            }
          ]
        }
      ],
      "id": "ping"
    },
    "remark": "nothing"
  }
  """
  println(bob)

  let d = toDynamicObjectTreeFromString(bob)

  println(d: id())
  println(d: remark())
  println(d: firstName()+ " " + d: lastName())
  println(d: things(): message(): text())
  println(d: things(): bidules(): get(1))
  println(d: things(): id())
  println(d: things(): bidules(): get(2): trucs(): get(2))
  println(d: things(): bidules(): get(2): trucs(): get(3): tools())
  println(d: things(): bidules(): get(2): trucs(): get(3): tools(): get(3): yo())

}
