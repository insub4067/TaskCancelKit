//
//  TaskCancelBag.swift
//
//
//  Created by 김인섭 on 4/2/24.
//

import Combine

/// A utility class for managing cancellable tasks.
public class TaskCancelBag<ID: Hashable> {
    
    /// A dictionary holding the cancellable tasks.
    private var bag: [ID: AnyCancellable] = [:]
    
    /// Initializes a new TaskCancelBag.
    public init() { }
    
    /// Cancels and removes the task associated with the given ID.
    /// - Parameter id: The ID of the task to cancel.
    public func cancel(id: ID) {
        bag[id]?.cancel()
        bag.removeValue(forKey: id)
    }
    
    /// Cancels all tasks and clears the bag.
    public func cancelAll() {
        bag.values.forEach { $0.cancel() }
        bag.removeAll()
    }
    
    /// Adds a task to the bag, cancelling any existing task with the same ID.
    /// - Parameters:
    ///   - id: The ID for the task.
    ///   - cancellable: The cancellable task to add.
    public func add(id: ID, cancellable: AnyCancellable) {
        bag[id]?.cancel()
        bag[id] = cancellable
    }
}
