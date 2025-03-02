import gleam/string
import glee
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

// Test for parse_json_string function
pub fn parse_json_string_test() {
  // Test with valid JSON
  let json = "{\"name\":\"John\",\"age\":30}"
  let result = glee.parse_json_string(json, "name")
  result
  |> should.equal("John")

  // Test with invalid field
  let result = glee.parse_json_string(json, "invalid_field")
  result
  |> should.equal("Error")

  // Test with invalid JSON
  let invalid_json = "{invalid_json"
  let result = glee.parse_json_string(invalid_json, "name")
  result
  |> should.equal("Error")
}

// Test for parse_json_number function
pub fn parse_json_number_test() {
  // Test with valid JSON
  let json = "{\"age\":30.5,\"score\":99}"
  let result = glee.parse_json_number(json, "age")
  result
  |> should.equal(Ok(30.5))

  // Test with invalid field
  let result = glee.parse_json_number(json, "invalid_field")
  result
  |> should.equal(Error("Failed to parse number"))

  // Test with invalid JSON
  let invalid_json = "{invalid_json"
  let result = glee.parse_json_number(invalid_json, "age")
  result
  |> should.equal(Error("Failed to parse number"))

  // Test with non-numeric field
  let json = "{\"name\":\"John\",\"age\":30.5}"
  let result = glee.parse_json_number(json, "name")
  result
  |> should.equal(Error("Failed to parse number"))
}

// Test for float_to_string function
pub fn float_to_string_test() {
  // Test with integer value
  let result = glee.float_to_string(42.0)
  result
  |> should.equal("42.0")

  // Test with one decimal place
  let result = glee.float_to_string(42.5)
  result
  |> should.equal("42.5")

  // Test with multiple decimal places (should truncate to 1)
  let result = glee.float_to_string(42.567)
  result
  |> should.equal("42.5")

  // Test with negative value
  let result = glee.float_to_string(-42.567)
  result
  |> should.equal("-42.5")
}

// Test for extract_value_from_json function
pub fn extract_value_from_json_test() {
  // Test with simple nested JSON
  let json = "{\"user\":{\"name\":\"John\",\"age\":30}}"
  let result = glee.extract_value_from_json(json, "user", "name")
  result
  |> should.equal("John")

  // Test with numeric value
  let result = glee.extract_value_from_json(json, "user", "age")
  result
  |> should.equal("30")

  // Test with invalid parent
  let result = glee.extract_value_from_json(json, "invalid_parent", "name")
  result
  |> should.equal("Unknown")

  // Test with invalid key
  let result = glee.extract_value_from_json(json, "user", "invalid_key")
  result
  |> should.equal("Unknown")

  // Test with more complex nested JSON
  let complex_json =
    "{\"data\":{\"user\":{\"profile\":{\"name\":\"Alice\",\"email\":\"alice@example.com\"}}}}"
  let result = glee.extract_value_from_json(complex_json, "data", "user")
  string.contains(result, "profile")
  |> should.be_true

  // Test with JSON containing arrays
  let array_json = "{\"results\":{\"items\":[1,2,3],\"count\":3}}"
  let result = glee.extract_value_from_json(array_json, "results", "count")
  result
  |> should.equal("3")
}
