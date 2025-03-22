// Comments, imports, and constants
import React, { useState, useEffect } from 'react';
const PI = 3.14159, MAX_COUNT = 100;

/**
 * @param {string} name - User name
 * @returns {string} Greeting message
 */
function greet(name = 'Guest') {
  return `Hello, ${name}! The time is ${new Date().toLocaleTimeString()}`;
}

// Class with methods and properties
class ColorDemo {
  static version = '1.0.0';
  #privateField = 'hidden';
  
  constructor(name) {
    this.name = name;
    this.created = new Date();
  }
  
  async fetchData() {
    try {
      const response = await fetch('https://api.example.com/data');
      return await response.json();
    } catch (error) {
      console.error(`Error: ${error.message}`);
      return null;
    }
  }
}

// Arrow functions, arrays, objects, and operations
const double = x => x * 2;
const numbers = [1, 2, 3, 4, 5];
const sum = numbers.reduce((a, b) => a + b, 0);
const evens = numbers.filter(n => n % 2 === 0);

const user = { name: 'Alice', age: 28, active: true };
const { name, ...rest } = user;
const regex = /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$/i;

// Conditionals and operations
if (user.active && user.age >= 18) {
  console.log(`${user.name} is an active adult user`);
} else if (user.name.match(regex)) {
  console.log('Valid email pattern');
}