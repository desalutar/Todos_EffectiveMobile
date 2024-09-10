//
//  Model&DTO.swift
//  Todos_EffectiveMobile
//
//  Created by Ишхан Багратуни on 10.09.24.
//

import Foundation

struct TaskResponse: Decodable {
    let todos: [TaskItemDTO]
    let total: Int
    let skip: Int
    let limit: Int
}

struct TaskItemDTO: Decodable {
    let id: Int
    let todo: String
    let taskDescription: String?
    let completed: Bool
    let userId: Int
    let date: Date?
}
