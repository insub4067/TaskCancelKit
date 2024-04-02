# TaskCancelKit
> TaskCancelKit is a Swift library designed to simplify the management of cancellable tasks, particularly useful for asynchronous operations in iOS and macOS applications. With TaskCancelKit, developers can easily cancel ongoing tasks, preventing unwanted side effects and managing resources efficiently.

## Features
Easy Task Management: Cancel individual or all tasks with simple method calls.
Type-Safe Task Identifiers: Utilize Swift's type system to manage tasks with custom identifiers.
Lightweight and Efficient: A minimalistic approach that's easy to integrate into any project.

## Requirements
- iOS 13.0+ / macOS 10.15+
- Swift 5.3+
## Installation
### Swift Package Manager
You can add TaskCancelKit to your project via Swift Package Manager by adding the following to your Package.swift file:
```swift
dependencies: [
    .package(url: "https://github.com/insub4067/TaskCancelKit.git", .upToNextMajor(from: "1.0.0"))
]
```

## Usage
### Creating a Cancel Bag
First, create an instance of TaskCancelBag where you can store your tasks.

```swift
import TaskCancelKit

private let cancelBag = TaskCancelBag<TaskID>()
```
### Storing Tasks
When you create a task, store it in your cancelBag using an identifier.

```swift
enum TaskID {
    case countThree
}

func executeAfterThreeSecond() {
    Task {
        try await Task.sleep(for: .seconds(3))
        print("Task Complete")
    }.store(in: cancelBag, id: .countThree)
}
```
### Cancelling Tasks
You can cancel tasks individually or all at once.
```swift
// Cancel a specific task
cancelBag.cancel(id: .countThree)

// Cancel all tasks
cancelBag.cancelAll()
```

## Example 
[GitHub Repository](https://github.com/insub4067/TaskCancelKitExample)

## Contributing
We welcome contributions to TaskCancelKit! Please read our Contributing Guide for details on how to propose bugfixes, features, and submit pull requests.

## License
TaskCancelKit is released under the MIT license. See LICENSE for more information.

