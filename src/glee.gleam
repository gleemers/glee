//// Glee
//// A simple way to parse JSON without
//// having to implement the JSON module.
//// +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//// This is my first time using Gleam, so
//// I'm sure there are some things that
//// could be done better.

import gleam/dynamic/decode
import gleam/json
import gleam/string

/// Parse a JSON string and return
/// the string value of a given field.
pub fn parse_json_string(json: String, field: String) -> Result(String, String) {
  let json_decoder = {
    use json <- decode.field(field, decode.string)
    decode.success(json)
  }

  // Parse the JSON string and return
  // the value of the given field.
  let json_result =
    json
    |> json.parse(json_decoder)

  // Return the value of the given field.
  case json_result {
    Ok(json_result) -> Ok(json_result)
    Error(_) -> Error("Failed to parse string")
  }
}

/// Parse a JSON string and return
/// the float value of a given field.
pub fn parse_json_float(json: String, field: String) -> Result(Float, String) {
  // Parse the JSON string and return
  // the value of the given field.
  let json_decoder = {
    use json <- decode.field(field, decode.float)
    decode.success(json)
  }

  // Parse the JSON string and return
  // the value of the given field.
  let json_result =
    json
    |> json.parse(json_decoder)

  // Return the value of the given field.
  case json_result {
    Ok(value) -> Ok(value)
    Error(_) -> Error("Failed to parse float")
  }
}

/// Parse a JSON string and return
/// the int value of a given field.
pub fn parse_json_int(json: String, field: String) -> Result(Int, String) {
  // Parse the JSON string and return
  // the value of the given field.
  let json_decoder = {
    use json <- decode.field(field, decode.int)
    decode.success(json)
  }

  // Parse the JSON string and return
  // the value of the given field.
  let json_result =
    json
    |> json.parse(json_decoder)

  // Return the value of the given field.
  case json_result {
    Ok(value) -> Ok(value)
    Error(_) -> Error("Failed to parse integer")
  }
}

/// Extract a value from a JSON string
/// by specifying the parent and key.
pub fn extract_value_from_json(
  json: String,
  parent: String,
  key: String,
) -> String {
  let parent_pattern = "\"" <> parent <> "\":{"
  let parent_parts = string.split(json, parent_pattern)

  case parent_parts {
    [_, parent_content, ..] -> {
      let key_pattern = "\"" <> key <> "\":"
      let key_parts = string.split(parent_content, key_pattern)

      case key_parts {
        [_, value_part, ..] -> {
          let by_comma = string.split(value_part, ",")
          let by_brace = string.split(value_part, "}")

          let value_by_comma = case by_comma {
            [first, ..] -> first
            _ -> value_part
          }

          let value_by_brace = case by_brace {
            [first, ..] -> first
            _ -> value_part
          }

          let value = case
            string.length(value_by_comma) < string.length(value_by_brace)
          {
            True -> value_by_comma
            False -> value_by_brace
          }

          let value = string.trim(value)

          let value = case
            string.starts_with(value, "\"") && string.ends_with(value, "\"")
          {
            True -> string.slice(value, 1, string.length(value) - 2)
            False -> value
          }

          value
        }
        _ -> "Unknown"
      }
    }
    _ -> "Unknown"
  }
}
