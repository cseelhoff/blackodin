package com.example.demo;

import java.util.*;
import java.util.stream.Collectors;
import java.time.LocalDateTime;

/**
 * Color theme demonstration for Java
 * @author Copilot
 */
public class ColorThemeDemo<T> implements Runnable {
    // Constants and fields
    private static final double PI = 3.14159;
    private final String name;
    private int counter = 0;
    
    // Enum definition
    public enum Status { PENDING, RUNNING, COMPLETED, FAILED }
    
    public ColorThemeDemo(String name) {
        this.name = name;
    }
    
    // Method with different elements
    public double calculateArea(double radius) throws IllegalArgumentException {
        if (radius < 0) {
            throw new IllegalArgumentException("Radius cannot be negative");
        }
        return PI * radius * radius;
    }
    
    // Lambda and streams demo
    public void processItems() {
        List<String> items = Arrays.asList("one", "two", "three");
        Map<Integer, String> map = items.stream()
                .filter(s -> s.length() > 2)
                .collect(Collectors.toMap(
                        String::length,
                        s -> s.toUpperCase()));
                
        for (var entry : map.entrySet()) {
            System.out.printf("Key: %d, Value: %s%n", entry.getKey(), entry.getValue());
        }
    }
    
    @Override
    public void run() {
        System.out.println("Running at: " + LocalDateTime.now());
    }
    
    public static void main(String[] args) {
        var demo = new ColorThemeDemo<>("Test");
        int value = 42;
        String text = "Hello, world!";
        boolean isActive = true;
        
        if (isActive && value > 40) {
            System.out.println(text + " The value is: " + value);
        }
    }
}