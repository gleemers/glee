import gleam/dynamic/decode
import gleam/json

/// Parse a JSON string and return
/// the string value of a given field.
pub fn glee_parse_json_string(
  json: String,
  field: String,
) -> Result(String, String) {
  let json_decoder = {
    use json <- decode.field(field, decode.string)
    decode.success(json)
  }

  let json_result =
    json
    |> json.parse(json_decoder)

  case json_result {
    Ok(json_result) -> Ok(json_result)
    Error(_) -> Error("Failed to parse string")
  }
}

/// Parse a JSON string and return
/// the float value of a given field.
pub fn glee_parse_json_float(
  json: String,
  field: String,
) -> Result(Float, String) {
  let json_decoder = {
    use json <- decode.field(field, decode.float)
    decode.success(json)
  }

  let json_result =
    json
    |> json.parse(json_decoder)

  case json_result {
    Ok(value) -> Ok(value)
    Error(_) -> Error("Failed to parse float")
  }
}

/// Parse a JSON string and return
/// the int value of a given field.
pub fn glee_parse_json_int(json: String, field: String) -> Result(Int, String) {
  // the value of the given field.
  let json_decoder = {
    use json <- decode.field(field, decode.int)
    decode.success(json)
  }

  let json_result =
    json
    |> json.parse(json_decoder)

  case json_result {
    Ok(value) -> Ok(value)
    Error(_) -> Error("Failed to parse integer")
  }
}
