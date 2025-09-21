import gleam/dict
import gleam/dynamic/decode
import gleam/float
import gleam/int
import gleam/json
import gleam/list
import gleam/string

/// Encode a string value into a JSON string
pub fn glee_encode_string(value: String) -> String {
  let escaped = string.replace(value, "\"", "\\\"")
  "\"" <> escaped <> "\""
}

/// Encode an int value into a JSON string
pub fn glee_encode_int(value: Int) -> String {
  int.to_string(value)
}

/// Encode a float value into a JSON string
pub fn glee_encode_float(value: Float) -> String {
  float.to_string(value)
}

/// Encode a boolean value into a JSON string
pub fn glee_encode_bool(value: Bool) -> String {
  case value {
    True -> "true"
    False -> "false"
  }
}

/// Encode a list of values into a JSON array string
pub fn glee_encode_list(values: List(String)) -> String {
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
pub fn glee_encode_object(values: dict.Dict(String, String)) -> String {
  let entries = dict.to_list(values)

  let joined_entries =
    list.fold(entries, "", fn(acc, entry) {
      let #(key, value) = entry
      let formatted_entry = glee_encode_string(key) <> ":" <> value

      case acc {
        "" -> formatted_entry
        _ -> acc <> "," <> formatted_entry
      }
    })

  "{" <> joined_entries <> "}"
}

/// Create a simple JSON object with a single key-value pair
pub fn glee_create_json_object(key: String, value: String) -> String {
  let values = dict.new()
  let values = dict.insert(values, key, value)
  glee_encode_object(values)
}

/// Create a JSON object from multiple key-value pairs
pub fn glee_create_json_object_from_pairs(
  pairs: List(#(String, String)),
) -> String {
  let values = dict.from_list(pairs)
  glee_encode_object(values)
}

/// Parse a JSON string and return
/// the boolean value of a given field.
pub fn glee_parse_json_bool(json: String, field: String) -> Result(Bool, String) {
  let json_decoder = {
    use json <- decode.field(field, decode.bool)
    decode.success(json)
  }

  let json_result =
    json
    |> json.parse(json_decoder)

  case json_result {
    Ok(value) -> Ok(value)
    Error(_) -> Error("Failed to parse boolean")
  }
}
