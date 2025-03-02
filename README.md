# glee

Glee is a simple way to parse JSON by taking in JSON and
returning a string.

This is my first package, i'm new to gleam- I'm sure there
are things I could do better

[![Package Version](https://img.shields.io/hexpm/v/glee)](https://hex.pm/packages/glee)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/glee/)

```sh
gleam add glee@2
```

## Decoding JSON

Glee also provides functions to decode JSON into values:

Getting a string:
```gleam
import glee
import gleam/io
import gleam/result

pub fn main() {
  let json = "{\"name\":\"John\",\"age\":30}"
  let result = glee.parse_json_string(json, "name")
  
  case result {
    Ok(name) -> io.println("Name: " <> name)
    Error(reason) -> io.println("Error: " <> reason)
  }
}
```

Getting a float:
```gleam
import glee
import gleam/io
import gleam/float
import gleam/result

pub fn main() {
  let json = "{\"name\":\"John\",\"age\":30.4}"
  let result = glee.parse_json_float(json, "age")
  
  case result {
    Ok(age) -> io.println("Age: " <> float.to_string(age))
    Error(reason) -> io.println("Error: " <> reason)
  }
}
```

Getting an int:
```gleam
import glee
import gleam/io
import gleam/int
import gleam/result

pub fn main() {
  let json = "{\"name\":\"John\",\"age\":30}"
  let result = glee.parse_json_int(json, "age")
  
  case result {
    Ok(age) -> io.println("Age: " <> int.to_string(age))
    Error(reason) -> io.println("Error: " <> reason)
  }
}
```

## Encoding JSON

Glee also provides functions to encode values into JSON:

```gleam
import glee
import gleam/io
import gleam/dict

pub fn main() {
  // Encode simple values
  let string_json = glee.encode_string("hello")  // "hello"
  let int_json = glee.encode_int(42)  // 42
  let float_json = glee.encode_float(3.14)  // 3.14
  let bool_json = glee.encode_bool(True)  // true
  
  // Create a simple JSON object
  let person = glee.create_json_object("name", glee.encode_string("Alice"))
  io.println(person)  // {"name":"Alice"}
  
  // Create a JSON object from multiple pairs
  let pairs = [
    #("name", glee.encode_string("Bob")),
    #("age", glee.encode_int(30)),
    #("active", glee.encode_bool(True))
  ]
  let complex_person = glee.create_json_object_from_pairs(pairs)
  io.println(complex_person)  // {"name":"Bob","age":30,"active":true}
  
  // Create a JSON array
  let values = [
    glee.encode_string("apple"),
    glee.encode_string("banana"),
    glee.encode_string("cherry")
  ]
  let fruits = glee.encode_list(values)
  io.println(fruits)  // ["apple","banana","cherry"]
}
```

Further documentation can be found at <https://hexdocs.pm/glee>.

## Development

```sh
gleam test  # Run the tests
```
