#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"
TODO_FILE="$SCRIPT_DIR/todo.txt"

touch "$TODO_FILE"

show_menu(){
    echo "TO DO LIST"
    echo "1. View tasks"
    echo "2. Add a task"
    echo "3. Mark as done"
    echo "4. Delete a task"
    echo "5. Exit"
    echo
}

view_tasks(){
    echo "Tasks listed here: "
    cat "$TODO_FILE"
    echo
}

add_tasks(){
    read -p "Enter task to be added: " task
    echo "[ ] $task" >> "$TODO_FILE"
    echo "Task added"
}

mark_done() {
    view_tasks
    read -p "Enter task to mark as done: " num

    if [ "$num" -gt 0 ] 2>/dev/null && [ "$num" -le "$(wc -l < "$TODO_FILE")" ]; then
        sed -i "${num}s/^\[ \]/[x]/" "$TODO_FILE"
        echo "Task marked as done."
    else
        echo "Invalid task number."
    fi
}

delete_task() {
    view_tasks
    read -p "Enter task to delete: " num

    if [ "$num" -gt 0 ] 2>/dev/null && [ "$num" -le "$(wc -l < "$TODO_FILE")" ]; then
        sed -i "${num}d" "$TODO_FILE"
        echo "Task deleted."
    else
        echo "Invalid task number."
    fi
}


while true; 
do
    show_menu
    read -p "Enter your choice: " choice

    if [[ $choice -eq 1 ]]
    then 
        view_tasks
    elif [[ $choice -eq 2 ]]
    then 
        add_tasks
    elif [[ $choice -eq 3 ]]
    then 
        mark_done
    elif [[ $choice -eq 4 ]]
    then 
        delete_task
    elif [[ $choice -eq 5 ]]
    then 
        exit 
    else
        echo "Invalid choice"
    fi
    echo
done
