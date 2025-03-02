//// Glee
//// A simple way to parse JSON without
//// having to implement the JSON module.
//// +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//// This is my first time using Gleam, so
//// I'm sure there are some things that
//// could be done better.

import gleam/dict
import gleam/dynamic/decode
import gleam/float
import gleam/int
import gleam/json
import gleam/list
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

/// Encode a string value into a JSON string
pub fn encode_string(value: String) -> String {
  let escaped = string.replace(value, "\"", "\\\"")
  "\"" <> escaped <> "\""
}

/// Encode an int value into a JSON string
pub fn encode_int(value: Int) -> String {
  int.to_string(value)
}

/// Encode a float value into a JSON string
pub fn encode_float(value: Float) -> String {
  float.to_string(value)
}

/// Encode a boolean value into a JSON string
pub fn encode_bool(value: Bool) -> String {
  case value {
    True -> "true"
    False -> "false"
  }
}

/// Encode a list of values into a JSON array string
pub fn encode_list(values: List(String)) -> String {
  let joined_values =
    list.fold(values, "", fn(acc, value) {
      case acc {
        "" -> value
        _ -> acc <> "," <> value
      }
    })

  "[" <> joined_values <> "]"
}

/// Encode a map of string keys and string values into a JSON object string
pub fn encode_object(values: dict.Dict(String, String)) -> String {
  let entries = dict.to_list(values)

  let joined_entries =
    list.fold(entries, "", fn(acc, entry) {
      let #(key, value) = entry
      let formatted_entry = encode_string(key) <> ":" <> value

      case acc {
        "" -> formatted_entry
        _ -> acc <> "," <> formatted_entry
      }
    })

  "{" <> joined_entries <> "}"
}

/// Create a simple JSON object with a single key-value pair
pub fn create_json_object(key: String, value: String) -> String {
  let values = dict.new()
  let values = dict.insert(values, key, value)
  encode_object(values)
}

/// Create a JSON object from multiple key-value pairs
pub fn create_json_object_from_pairs(pairs: List(#(String, String))) -> String {
  let values = dict.from_list(pairs)
  encode_object(values)
}

/// Parse a JSON string and return
/// the boolean value of a given field.
pub fn parse_json_bool(json: String, field: String) -> Result(Bool, String) {
  // Parse the JSON string and return
  // the value of the given field.
  let json_decoder = {
    use json <- decode.field(field, decode.bool)
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
    Error(_) -> Error("Failed to parse boolean")
  }
}
