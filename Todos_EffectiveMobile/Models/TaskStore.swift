//
//  Model.swift
//  Todos_EffectiveMobile
//
//  Created by Ишхан Багратуни on 03.09.24.
//

import Foundation
import CoreData

class TaskStore: ObservableObject {
    @Published var tasks: [TaskItem] = []
    @Published @MainActor var isLoading = true
    @Published var coreDM: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDM = coreDataManager
    }
    
    @MainActor
    func fetchTasks() async {
        isLoading = true
        
        do {
            let taskItemsDTO = try await APIService.shared.fetchTasksFromAPI()
            // Сохраняем данные в Core Data
            for taskItemDTO in taskItemsDTO {
                coreDM.saveTask(
                    id: taskItemDTO.id,
                    todo: taskItemDTO.todo,
                    description: taskItemDTO.taskDescription,
                    completed: taskItemDTO.completed,
                    userId: taskItemDTO.userId,
                    date: taskItemDTO.date
                )
            }
            tasks = coreDM.getAllTasks().sorted { $0.userId > $1.userId }
            coreDM.refreshTasks()
        } catch {
            print("Error fetching tasks: \(error.localizedDescription)")
        }
        isLoading = false
    }
}
