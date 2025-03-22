#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Color Theme Demo for Python"""

import os
import json
from typing import List, Dict, Optional, Union
from dataclasses import dataclass
from enum import Enum, auto

# Constants and variables
PI = 3.14159
COLORS = ["red", "green", "blue"]
active = True
count = 42
message = f"The count is {count} and PI is {PI:.2f}"

# Enum and dataclass
class Status(Enum):
    PENDING = auto()
    RUNNING = auto()
    COMPLETED = auto()

@dataclass
class Point:
    x: float
    y: float
    label: Optional[str] = None
    
    def distance_from_origin(self) -> float:
        return (self.x**2 + self.y**2)**0.5

# Function with docstring and type hints
def process_data(items: List[int], factor: int = 1) -> Dict[str, int]:
    """Process a list of integers with the given factor.
    
    Args:
        items: List of integers to process
        factor: Multiplier for each value
    """
    result = {}
    for i, value in enumerate(items):
        result[f"item_{i}"] = value * factor
    return result

# List/dict comprehensions and conditional logic
numbers = [1, 2, 3, 4, 5]
squares = [x**2 for x in numbers if x % 2 == 0]
user_data = {"name": "Alice", "age": 28, "active": True}

if user_data["active"] and user_data["age"] >= 18:
    print(f"{user_data['name']} is an active adult user")
elif any(x > 10 for x in numbers):
    print("At least one number is greater than 10")