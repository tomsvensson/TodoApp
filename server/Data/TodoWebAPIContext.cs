using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using TodoWebAPI.Models;

namespace TodoWebAPI.Data
{
    public class TodoWebAPIContext : DbContext
    {
        public TodoWebAPIContext (DbContextOptions<TodoWebAPIContext> options)
            : base(options)
        {
            Database.EnsureCreated();
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer(
                @"Data Source=localhost;Initial Catalog=TodoDB;Integrated Security=True");
        }

        public DbSet<TodoWebAPI.Models.Todo> Todo { get; set; } = default!;
    }
}
