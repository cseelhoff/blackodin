//! A color theme demo module for Rust
#![allow(dead_code)]

use std::{collections::HashMap, sync::{Arc, Mutex}, fmt::Display};
use anyhow::{Result, anyhow};

/// Represents user status
#[derive(Debug, Clone, PartialEq)]
pub enum Status {
    Active,
    Inactive,
    Pending { reason: String },
}

// Struct with lifetime and generics
pub struct User<'a, T: Display> {
    id: u64,
    name: &'a str,
    data: T,
    status: Status,
}

// Trait definition
pub trait Processor {
    fn process(&self, data: &str) -> Result<String>;
    fn get_id(&self) -> u64 { 42 } // Default implementation
}

impl<'a, T: Display> User<'a, T> {
    // Associated function (static method)
    pub fn new(id: u64, name: &'a str, data: T) -> Self {
        User { id, name, data, status: Status::Pending { reason: String::from("New user") } }
    }
    
    // Method with pattern matching
    pub fn describe(&self) -> String {
        let status_desc = match &self.status {
            Status::Active => "active",
            Status::Inactive => "inactive",
            Status::Pending { reason } => &reason,
        };
        format!("User {} ({}) - {}: {}", self.id, self.name, status_desc, self.data)
    }
}

// Main function with async, let binding, and error handling
pub async fn process_data(input: &str) -> Result<HashMap<String, i32>> {
    let mut map = HashMap::new();
    let numbers = vec![1, 2, 3];
    
    // Closures and iterators
    let sum: i32 = numbers.iter().map(|x| x * 2).sum();
    let _hex = 0xDEADBEEF_u32;
    let _bin = 0b1010_1010;
    let s = r#"Raw string with "quotes""#;
    
    if !input.is_empty() {
        map.insert(input.to_string(), sum);
        Ok(map)
    } else {
        Err(anyhow!("Empty input"))
    }
}