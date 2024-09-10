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
    @Published var isLoading = true
    
    let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    @MainActor
    func fetchTasks() async {
        isLoading = true
        
        do {
            // Получаем данные с API
            let taskItemsDTO = try await APIService.shared.fetchTasksFromAPI()
            
            // Сохраняем данные в Core Data
            for taskItemDTO in taskItemsDTO {
                coreDataManager.saveTask(
                    id: taskItemDTO.id,
                    todo: taskItemDTO.todo,
                    description: taskItemDTO.taskDescription,
                    completed: taskItemDTO.completed,
                    userId: taskItemDTO.userId,
                    date: taskItemDTO.date
                )
            }
            
            // Обновляем задачи
            tasks = coreDataManager.getAllTasks()
        } catch {
            print("Error fetching tasks: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
}
