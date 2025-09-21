/// Glee
/// A simple way to parse JSON without
/// having to implement the JSON module.
import decoder.{
  glee_parse_json_float, glee_parse_json_int, glee_parse_json_string,
}
import encoder.{
  glee_create_json_object, glee_create_json_object_from_pairs, glee_encode_bool,
  glee_encode_float, glee_encode_int, glee_encode_list, glee_encode_object,
  glee_encode_string, glee_parse_json_bool,
}

import utils.{glee_extract_value_from_json}

pub const parse_json_float = glee_parse_json_float

pub const parse_json_int = glee_parse_json_int

pub const parse_json_string = glee_parse_json_string

pub const parse_json_bool = glee_parse_json_bool

pub const encode_string = glee_encode_string

pub const encode_int = glee_encode_int

pub const encode_float = glee_encode_float

pub const encode_bool = glee_encode_bool

pub const encode_list = glee_encode_list

pub const encode_object = glee_encode_object

pub const create_json_object = glee_create_json_object

pub const create_json_object_from_pairs = glee_create_json_object_from_pairs

pub const extract_value_from_json = glee_extract_value_from_json
