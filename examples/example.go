// Package colorthemedemo demonstrates Go syntax highlighting elements
package colorthemedemo

import (
    "context"
    "errors"
    "fmt"
    "sync"
    "time"
)

// Constants and variables
const (
    MaxRetries   = 3
    defaultValue = "default"
)

var (
    ErrNotFound = errors.New("not found")
    validModes  = map[string]bool{"fast": true, "safe": true}
)

// User represents a system user
type User struct {
    ID        int
    Name      string
    CreatedAt time.Time
    Active    bool
}

// Stringer interface definition
type Stringer interface {
    String() string
}

// Implement String method for User
func (u *User) String() string {
    return fmt.Sprintf("User{%d, %s, active=%t}", u.ID, u.Name, u.Active)
}

// Process handles data with error handling and multiple returns
func Process(ctx context.Context, data []byte) (result string, count int, err error) {
    // Defer statement
    defer func() {
        if r := recover(); r != nil {
            err = fmt.Errorf("panic: %v", r)
        }
    }()

    // Select statement with channels
    select {
    case <-ctx.Done():
        return "", 0, ctx.Err()
    case <-time.After(100 * time.Millisecond):
        // Continue processing
    }

    // Switch with type assertion
    var value interface{} = "test"
    switch v := value.(type) {
    case string:
        return v + "_processed", len(v), nil
    case int:
        return fmt.Sprintf("%d", v), v, nil
    default:
        return "", 0, fmt.Errorf("unsupported type: %T", v)
    }
}

// FetchUsers demonstrates goroutines, channels, and range
func FetchUsers(ids []int) []User {
    var wg sync.WaitGroup
    results := make(chan User, len(ids))

    // Anonymous function in goroutine
    for _, id := range ids {
        wg.Add(1)
        go func(userID int) {
            defer wg.Done()
            // If statement with short declaration
            if user, ok := fetchUser(userID); ok {
                results <- user
            }
        }(id)
    }

    // Wait and close channel
    go func() {
        wg.Wait()
        close(results)
    }()

    // Collect results with range
    users := []User{}
    for user := range results {
        users = append(users, user)
    }
    return users
}