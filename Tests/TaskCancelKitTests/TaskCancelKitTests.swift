import XCTest
@testable import TaskCancelKit

final class TaskCancelKitTests: XCTestCase {
    
    func testTaskExecutesAsExpected() {
        let cancelBag = TaskCancelBag<String>()
        let expectation = XCTestExpectation(description: "Task should complete execution")

        // Define a unique identifier for the task
        let taskID = "completableTask"

        // Create and start a task
        let task = Task {
            // Simulate a task that takes time to complete, e.g., a network call or a long computation
            try await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
            // Indicate that the task has completed as expected
            expectation.fulfill()
        }

        // Store the task in the cancel bag without cancelling it
        task.store(in: cancelBag, id: taskID)

        // Wait for the expectation to be fulfilled, with a timeout slightly longer than the task's expected duration
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testAddingAndCancellingTask() {
        let cancelBag = TaskCancelBag<String>()
        let expectation = XCTestExpectation(description: "Task should be cancelled")

        let task = Task {
            try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
            XCTFail("Task was not cancelled")
        }

        task.store(in: cancelBag, id: "testTask")

        // Cancel the task immediately
        cancelBag.cancel(id: "testTask")

        // Use an expectation to wait for a short period of time to ensure the task has been cancelled
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testCancellingAllTasks() {
        let cancelBag = TaskCancelBag<String>()
        let expectation1 = XCTestExpectation(description: "First task should be cancelled")
        let expectation2 = XCTestExpectation(description: "Second task should be cancelled")

        let task1 = Task {
            try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
            XCTFail("First task was not cancelled")
        }
        let task2 = Task {
            try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
            XCTFail("Second task was not cancelled")
        }

        task1.store(in: cancelBag, id: "task1")
        task2.store(in: cancelBag, id: "task2")

        // Cancel all tasks immediately
        cancelBag.cancelAll()

        // Use expectations to wait for a short period of time to ensure the tasks have been cancelled
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation1.fulfill()
            expectation2.fulfill()
        }

        wait(for: [expectation1, expectation2], timeout: 1.0)
    }
}
