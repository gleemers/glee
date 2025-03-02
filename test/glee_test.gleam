import gleam/dict
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
  |> should.equal(Ok("John"))

  // Test with invalid field
  let result = glee.parse_json_string(json, "invalid_field")
  result
  |> should.equal(Error("Failed to parse string"))

  // Test with invalid JSON
  let invalid_json = "{invalid_json"
  let result = glee.parse_json_string(invalid_json, "name")
  result
  |> should.equal(Error("Failed to parse string"))
}

// Test for parse_json_float function
pub fn parse_json_float_test() {
  // Test with valid JSON
  let json = "{\"age\":30.5,\"score\":99}"
  let result = glee.parse_json_float(json, "age")
  result
  |> should.equal(Ok(30.5))

  // Test with invalid field
  let result = glee.parse_json_float(json, "invalid_field")
  result
  |> should.equal(Error("Failed to parse float"))

  // Test with invalid JSON
  let invalid_json = "{invalid_json"
  let result = glee.parse_json_float(invalid_json, "age")
  result
  |> should.equal(Error("Failed to parse float"))

  // Test with non-numeric field
  let json = "{\"name\":\"John\",\"age\":30.5}"
  let result = glee.parse_json_float(json, "name")
  result
  |> should.equal(Error("Failed to parse float"))
}

// Test for parse_json_int function
pub fn parse_json_int_test() {
  // Test with valid JSON
  let json = "{\"age\":30,\"score\":99}"
  let result = glee.parse_json_int(json, "age")
  result
  |> should.equal(Ok(30))

  // Test with invalid field
  let result = glee.parse_json_int(json, "invalid_field")
  result
  |> should.equal(Error("Failed to parse integer"))

  // Test with invalid JSON
  let invalid_json = "{invalid_json"
  let result = glee.parse_json_int(invalid_json, "age")
  result
  |> should.equal(Error("Failed to parse integer"))

  // Test with non-numeric field
  let json = "{\"name\":\"John\",\"age\":30.5}"
  let result = glee.parse_json_int(json, "name")
  result
  |> should.equal(Error("Failed to parse integer"))
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

// Test for encode_string function
pub fn encode_string_test() {
  let result = glee.encode_string("hello")
  result
  |> should.equal("\"hello\"")

  let result = glee.encode_string("hello \"world\"")
  result
  |> should.equal("\"hello \\\"world\\\"\"")
}

// Test for encode_int function
pub fn encode_int_test() {
  let result = glee.encode_int(42)
  result
  |> should.equal("42")

  let result = glee.encode_int(-10)
  result
  |> should.equal("-10")
}

// Test for encode_float function
pub fn encode_float_test() {
  let result = glee.encode_float(42.5)
  result
  |> should.equal("42.5")

  let result = glee.encode_float(-10.25)
  result
  |> should.equal("-10.25")
}

// Test for encode_bool function
pub fn encode_bool_test() {
  let result = glee.encode_bool(True)
  result
  |> should.equal("true")

  let result = glee.encode_bool(False)
  result
  |> should.equal("false")
}

// Test for encode_list function
pub fn encode_list_test() {
  let values = ["\"hello\"", "42", "true"]
  let result = glee.encode_list(values)
  result
  |> should.equal("[\"hello\",42,true]")

  let empty_list = []
  let result = glee.encode_list(empty_list)
  result
  |> should.equal("[]")
}

// Test for encode_object function
pub fn encode_object_test() {
  let values =
    dict.from_list([#("name", "\"John\""), #("age", "30"), #("active", "true")])

  let result = glee.encode_object(values)

  // Since dict doesn't guarantee order, we need to check for the presence of each key-value pair
  result
  |> string.contains("\"name\":\"John\"")
  |> should.be_true

  result
  |> string.contains("\"age\":30")
  |> should.be_true

  result
  |> string.contains("\"active\":true")
  |> should.be_true

  result
  |> string.starts_with("{")
  |> should.be_true

  result
  |> string.ends_with("}")
  |> should.be_true
}

// Test for create_json_object function
pub fn create_json_object_test() {
  let result = glee.create_json_object("name", "\"John\"")
  result
  |> should.equal("{\"name\":\"John\"}")
}

// Test for create_json_object_from_pairs function
pub fn create_json_object_from_pairs_test() {
  let pairs = [#("name", "\"John\""), #("age", "30")]

  let result = glee.create_json_object_from_pairs(pairs)

  // Since dict doesn't guarantee order,
  //we need to check for the presence of each key-value pair
  result
  |> string.contains("\"name\":\"John\"")
  |> should.be_true

  result
  |> string.contains("\"age\":30")
  |> should.be_true

  result
  |> string.starts_with("{")
  |> should.be_true

  result
  |> string.ends_with("}")
  |> should.be_true
}

pub fn parse_json_bool_test() {
  let result = glee.parse_json_bool("{\"active\":true}", "active")
  result
  |> should.equal(Ok(True))
}
