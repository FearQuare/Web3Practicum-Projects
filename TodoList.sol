// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

// Insert, update, read from array of structs

contract TodoList {
    struct Todo {
        string text; //Description of the Todo
        bool completed; //The status of the Todo | Whether it's completed or not.
    }

    Todo[] public todos;

    // Below function will create and insert a new todo.
    function create(string calldata _text) external {
        todos.push(Todo({
            text: _text,
            completed: false
        }));
    }

    function updateText(uint _index, string calldata _text) external {
        todos[_index].text = _text; //This will be cheaper if you update single field.

       // Todo storage todo = todos[_index];
        //todo.text = _text; --> If you do multiple this will be cheaper.
        //these two above do the same thing.

        /*
        For example:

        --> 35138 gas
        todos[_index].text = _text; | Because in here we are accessing 4 times to the array.
        todos[_index].text = _text;
        todos[_index].text = _text;
        todos[_index].text = _text;

        --> 34578 gas
        Todo storage todo = todos[_index]; | Array will be accessed for once.
        todo.text = _text;
        todo.text = _text;
        todo.text = _text;
        todo.text = _text;
        */
    }

    function get(uint _index) external view returns (string memory, bool){
        // storage - 29397
        // memory - 29480
        Todo storage todo = todos[_index];
        return (todo.text, todo.completed);
    }

    function toggleCompleted(uint _index) external {
        todos[_index].completed = !todos[_index].completed;
    }
}