//
//  APIServices.swift
//  Todos_EffectiveMobile
//
//  Created by Ишхан Багратуни on 10.09.24.
//

import Foundation

class APIService {
    static let shared = APIService()

    func fetchTasksFromAPI() async throws -> [TaskItemDTO] {
        guard let apiURL = URL(string: "https://dummyjson.com/todos") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: apiURL)
        let taskResponse = try JSONDecoder().decode(TaskResponse.self, from: data)
        
        return taskResponse.todos
    }
}
