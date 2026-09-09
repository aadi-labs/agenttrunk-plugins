use crate::ApiError;
// Encode every user-controlled route segment before reqwest parses the URL.
pub fn path_param(value:&str)->Result<String,ApiError>{
 if value.is_empty() || value=="." || value==".." || value.chars().any(|c|c.is_control()){return Err(ApiError::InvalidHeader);}
 let mut output=String::new();for b in value.bytes(){if b.is_ascii_alphanumeric()||b"-._~".contains(&b){output.push(b as char);}else{output.push_str(&format!("%{b:02X}"));}}Ok(output)
}
