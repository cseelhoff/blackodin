using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Text.RegularExpressions;

namespace ColorThemeDemo
{
    // Enum definition
    public enum Status { Pending, Active, Completed, Failed }

    // Interface with generic constraint
    public interface IRepository<T> where T : class, new()
    {
        Task<T?> GetByIdAsync(int id);
        IEnumerable<T> GetAll(Func<T, bool> predicate);
    }

    // Record type (C# 9.0+)
    public record Person(string Name, int Age)
    {
        public string Email { get; init; } = string.Empty;
    }

    // Attribute usage
    [Serializable]
    public class User : IComparable<User>
    {
        // Properties with different accessors
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        private DateTime _createdAt = DateTime.Now;
        public bool IsActive { get; protected set; }
        
        // Expression-bodied member and string interpolation
        public string FullInfo => $"{Id}: {Name} (Active: {IsActive})";
        
        // Method with out parameter and pattern matching
        public bool TryGetCreationYear(out int year)
        {
            year = _createdAt.Year;
            return _createdAt is { Year: > 2000 };
        }
        
        // Implementing interface method
        public int CompareTo(User? other) => other is null ? 1 : Id.CompareTo(other.Id);
        
        // Async method with exception handling
        public async Task<bool> ValidateAsync()
        {
            try
            {
                await Task.Delay(100); // Simulating async operation
                return Regex.IsMatch(Name, @"^[A-Za-z ]{2,50}$");
            }
            catch (Exception ex) when (ex is not OperationCanceledException)
            {
                Console.WriteLine($"Validation error: {ex.Message}");
                return false;
            }
        }
    }
    
    // Extension method
    public static class Extensions
    {
        public static string Truncate(this string value, int maxLength) => 
            value?.Length > maxLength ? value.Substring(0, maxLength) : value;
    }
    
    // Main program with LINQ and lambda expressions
    public class Program
    {
        public static async Task Main(string[] args)
        {
            List<User> users = new() { new User { Id = 1, Name = "Alice" } };
            
            // LINQ and switch expression
            var result = users
                .Where(u => u.IsActive)
                .Select(u => new { u.Id, Status = u.Id switch {
                    <= 0 => Status.Failed,
                    < 10 => Status.Active,
                    _ => Status.Completed
                }})
                .ToList();
        }
    }
}