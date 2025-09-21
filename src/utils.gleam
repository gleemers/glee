import gleam/string

/// Extract a value from a JSON string
/// by specifying the parent and key.
pub fn glee_extract_value_from_json(
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
