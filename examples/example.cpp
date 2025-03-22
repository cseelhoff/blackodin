/**
 * @file color_theme_demo.cpp
 * @brief C++ syntax highlighting demonstration
 */
#include <iostream>
#include <vector>
#include <string>
#include <memory>
#include <algorithm>

#define MAX_SIZE 100
constexpr double PI = 3.14159265359;

// Enum and structure
enum class Status { PENDING, RUNNING, COMPLETED, FAILED };

struct Point {
    double x;
    double y;
    
    double distance_to(const Point& other) const {
        return std::sqrt(std::pow(x - other.x, 2) + std::pow(y - other.y, 2));
    }
};

// Class with templates
template<typename T>
class DataProcessor {
public:
    explicit DataProcessor(const std::string& name) : name_(name) {}
    
    template<typename U = T>
    auto process(const U& value) {
        if constexpr (std::is_arithmetic_v<U>) {
            return value * 2;
        } else {
            return value + value;
        }
    }
    
private:
    std::string name_;
};

// Main function with various elements
int main() {
    // Variable declarations and literals
    int count = 42;
    double value = 3.14;
    bool is_active = true;
    char character = 'A';
    std::string text = "Hello, World!";
    
    // STL containers and smart pointers
    std::vector<int> numbers = {1, 2, 3, 4, 5};
    auto processor = std::make_unique<DataProcessor<int>>("demo");
    
    // Control flow and algorithms
    if (is_active && count > 0) {
        std::for_each(numbers.begin(), numbers.end(), [](int& n) {
            n = n * 2;
        });
    }
    
    try {
        for (const auto& num : numbers) {
            std::cout << "Value: " << num << std::endl;
        }
    } catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << std::endl;
    }
    
    return 0;
}