#To-Do List App

This is a To-Do List app developed with Swift and CoreData. It helps users to manage their daily tasks by adding, updating, completing, and deleting tasks.

#Features

Add New Tasks: Users can add new tasks with a name, description, and due date.

View Task Details: Users can see the details of a specific task, including its name, description, creation date, end date, and completion status.

Mark Tasks as Completed: Users can mark tasks as completed. Once completed, tasks will move to the bottom of the list.

Edit and Delete Tasks: Users can edit existing tasks or delete them.

Filter Completed Tasks: Users can filter and display only the completed tasks.

#How to Use

Adding a Task:
Tap the + button in the top right corner.

A form will appear asking for the task name and description.

Select the due date using the date picker.

Tap "Submit" to add the task to the list.

Viewing Task Details:
Tap on any task in the list.

The ToDoDetayViewController will open, showing the task's name, description, creation date, end date, and completion status.

Marking a Task as Completed:
Tap the "Completed" button next to the task.

The task will move to the bottom of the list and will be marked as completed.

Editing or Deleting a Task:
Swipe left on a task to reveal the "Delete" and "Edit" buttons.

Tap Edit to modify the task's details, such as name, description, or due date.

Tap Delete to remove the task from the list.

Filter Completed Tasks:
Tap the "Show Completed" button to filter the tasks and show only those marked as completed.

#Technical Details


Framework: UIKit, CoreData

Design Pattern: MVVM (Model-View-ViewModel)

Persistent Storage: CoreData is used to store the tasks.

#MVVM Architecture:

View: Displays the user interface, such as the task list and task details.

ViewModel: Handles the logic and business rules, such as creating, updating, or deleting tasks. It communicates with the CoreDataManager to persist the data.

Model: Represents the data structure, in this case, a ToDoListItem object.




