<template>
  <div class="home">
    <h1>TODO</h1>
    <div class="todo-container">
      <div class="todo-input">
        <input 
          v-model="newTodo" 
          placeholder="Add new task" 
          @keyup.enter="addTodo" 
        />
        <button @click="addTodo">Add</button>
      </div>
      <ul class="todo-list">
        <li v-for="todo in todos" :key="todo.id" :class="{ done: todo.isDone }">
          <span @click="toggleTodo(todo)">{{ todo.text }}</span>
          <div class="button-group">
            <button 
              :class="todo.isDone ? 'uncomplete-button' : 'complete-button'" 
              @click="toggleTodo(todo)"
            >
              {{ todo.isDone ? 'Uncomplete' : 'Complete' }}
            </button>
            <button 
              class="remove-button" 
              @click="removeTodo(todo.id)"
            >
              Remove
            </button>
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  name: 'HomeView',
  data() {
    return {
      newTodo: '',
      todos: [],
    };
  },
  methods: {
    async fetchTodos() {
      try {
        const response = await fetch('http://localhost:5036/api/todos');
        if (!response.ok) throw new Error('Failed to fetch todos');
        this.todos = await response.json();
      } catch (error) {
        console.error('Error fetching todos:', error);
      }
    },
    async addTodo() {
      if (this.newTodo.trim()) {
        try {
          const newTodo = { text: this.newTodo, isDone: false };
          const response = await fetch('http://localhost:5036/api/todos', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(newTodo),
          });
          if (!response.ok) throw new Error('Failed to add todo');
          const createdTodo = await response.json();
          this.todos.push(createdTodo);
          this.newTodo = '';
        } catch (error) {
          console.error('Error adding todo:', error);
        }
      }
    },
    async toggleTodo(todo) {
      try {
        todo.isDone = !todo.isDone;
        const response = await fetch(`http://localhost:5036/api/todos/${todo.id}`, {
          method: 'PUT',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(todo),
        });
        if (!response.ok) throw new Error('Failed to update todo');
      } catch (error) {
        console.error('Error updating todo:', error);
      }
    },
    async removeTodo(id) {
      try {
        const response = await fetch(`http://localhost:5036/api/todos/${id}`, {
          method: 'DELETE',
        });
        if (!response.ok) throw new Error('Failed to delete todo');
        this.todos = this.todos.filter(todo => todo.id !== id);
      } catch (error) {
        console.error('Error deleting todo:', error);
      }
    },
  },
  created() {
    this.fetchTodos();
  },
};
</script>

<style scoped>
.todo-container {
  width: 60%;
  margin: 0 auto; 
}

.todo-input {
  margin-bottom: 20px;
}

.todo-input input {
  padding: 10px;
  font-size: 16px;
}

.todo-input button {
  padding: 10px 15px;
  font-size: 16px;
  margin-left: 10px;
  cursor: pointer;
}

.todo-list {
  list-style: none;
  padding: 0;
}

.todo-list li {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px;
  border-bottom: 1px solid #ccc;
}

.todo-list li.done span {
  text-decoration: line-through;
  color: gray;
}

.todo-list li span {
  cursor: pointer;
}

.todo-list li .button-group {
  display: flex;
  gap: 10px; 
}

.todo-list li button {
  border: none;
  padding: 5px 10px;
  cursor: pointer;
}

.todo-list li .complete-button {
  background: green;
  color: white;
}

.todo-list li .uncomplete-button {
  background: gray;
  color: white;
}

.todo-list li .remove-button {
  background: red;
  color: white;
}
</style>