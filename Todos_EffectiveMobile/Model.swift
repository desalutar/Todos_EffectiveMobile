//
//  Model.swift
//  Todos_EffectiveMobile
//
//  Created by Ишхан Багратуни on 03.09.24.
//

import Foundation

struct TaskModel: Decodable, Identifiable {
    let id: Int
    var title: String
    var description: String?
    var completed: Bool
    var userId: Int
    var date: Date?

    init(
        id: Int,
        title: String,
        description: String?,
        completed: Bool,
        userId: Int,
        date: Date? = nil
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.completed = completed
        self.userId = userId
        self.date = date
    }
}

class TaskStore: ObservableObject {
    @Published var tasks: [TaskModel] = []
}
