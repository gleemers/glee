# glee

Glee is a simple way to parse JSON by taking in JSON and
returning a string.

This is my first package, i'm new to gleam- Im sure there
are things I could do better

[![Package Version](https://img.shields.io/hexpm/v/glee)](https://hex.pm/packages/glee)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/glee/)

```sh
gleam add glee@1
```
```gleam
import glee

pub fn main() {
  let json = "{\"name\":\"John\",\"age\":30}"
  let result = glee.parse_json_string(json, "name")
  io.println("Name: " <> result)
}
```

Further documentation can be found at <https://hexdocs.pm/glee>.

## Development

```sh
gleam test  # Run the tests
```
