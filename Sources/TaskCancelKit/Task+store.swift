//
//  Task+store.swift
//  
//
//  Created by 김인섭 on 4/2/24.
//

import Combine

public extension Task {
    
    func store<ID: Hashable>(in bag: TaskCancelBag<ID>, id: ID) {
        bag.add(id: id, cancellable: AnyCancellable(cancel))
    }
}

