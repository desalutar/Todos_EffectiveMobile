//
//  Model.swift
//  Todos_EffectiveMobile
//
//  Created by Ишхан Багратуни on 03.09.24.
//

import Foundation

struct TaskResponse: Decodable {
    let todos: [TaskModel]
    let total: Int
    let skip: Int
    let limit: Int
}

struct TaskModel: Decodable, Identifiable, Equatable {
    let id: Int
    var todo: String
    var description: String?
    var completed: Bool
    var userId: Int
    var date: Date?
    
    init(
        id: Int,
        todo: String,
        description: String?,
        completed: Bool,
        userId: Int,
        date: Date? = nil
    ) {
        self.id = id
        self.todo = todo
        self.description = description
        self.completed = completed
        self.userId = userId
        self.date = date
    }
}

class TaskStore: ObservableObject {
    @Published @MainActor var tasks: [TaskModel] = []
    @Published @MainActor var isLoading = true
    
    @MainActor
    func fetchTasks() async {
        isLoading = true
        
        do {
            let (data, _) = try await URLSession.shared.data(from: URL(string: "https://dummyjson.com/todos")!)
            let response = try JSONDecoder().decode(TaskResponse.self, from: data)
            
            tasks = response.todos
        } catch {
            print("Error fetching tasks: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
}
enum APIError: Error {
    case invalidURL
    case noData
}
