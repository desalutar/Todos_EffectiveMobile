//
//  Model.swift
//  Todos_EffectiveMobile
//
//  Created by Ишхан Багратуни on 03.09.24.
//

import Foundation

struct TaskModel: Decodable, Identifiable {
    var id: Int
    var todo: String
    var description: String?
    var completed: Bool
    var userId: Int
    var date: Date
}

class TaskStore: ObservableObject {
    @Published var tasks: [TaskModel] = []
}
