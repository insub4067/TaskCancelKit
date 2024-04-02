//
//  TaskCancelBag.swift
//
//
//  Created by 김인섭 on 4/2/24.
//

import Combine

public class TaskCancelBag<ID: Hashable> {
    
    private var bag: [ID: AnyCancellable] = [:]
    
    public init() { }
    
    deinit {
        bag.values.forEach { $0.cancel() }
    }
    
    public func cancel(id: ID) {
        bag[id]?.cancel()
        bag.removeValue(forKey: id)
    }
    
    public func cancelAll() {
        bag.values.forEach { $0.cancel() }
        bag.removeAll()
    }
    
    public func add(id: ID, cancellable: AnyCancellable) {
        bag[id]?.cancel()
        bag[id] = cancellable
    }
}

