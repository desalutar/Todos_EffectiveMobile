//
//  Model.swift
//  Todos_EffectiveMobile
//
//  Created by Ишхан Багратуни on 03.09.24.
//

import Foundation

struct TaskModel: Equatable, Identifiable {
    var id: UUID
    var todo: String
    var completed: Bool
    var userId: Int
}
