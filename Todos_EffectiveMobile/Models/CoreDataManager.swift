//
//  CoreDataManager.swift
//  Todos_EffectiveMobile
//
//  Created by Ишхан Багратуни on 10.09.24.
//

import Foundation
import CoreData

class CoreDataManager {
    var taskItems: [TaskItem] = []
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "TaskItem")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data Store failed: \(error.localizedDescription) ")
            }
        }
    }
    
    func refreshTasks() {
        let allTasks = getAllTasks().sorted { $0.userId > $1.userId }
        taskItems = allTasks
    }
    
    func getAllTasks() -> [TaskItem] {
        let fetchRequest: NSFetchRequest<TaskItem> = TaskItem.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func saveTask(
        id: Int,
        todo: String,
        description: String? = "",
        completed: Bool,
        userId: Int,
        date: Date? = .now
    ) {
        let task = TaskItem(context: persistentContainer.viewContext)
        task.id = Int32(id)
        task.todo = todo
        task.taskDescription = description
        task.completed = completed
        task.userId = Int32(userId)
        task.date = date
        
        do {
            try persistentContainer.viewContext.save()
            refreshTasks()  // Обновление списка задач после сохранения
        } catch {
            print("Failed to save task: \(error.localizedDescription)")
        }
    }
    
    func updateTask(
            id: Int,
            todo: String,
            description: String? = "",
            completed: Bool,
            userId: Int,
            date: Date? = .now
        ) {
            let fetchRequest: NSFetchRequest<TaskItem> = TaskItem.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %d", id)
            
            do {
                guard let task = try persistentContainer.viewContext.fetch(fetchRequest).first else {
                    print("Task with id \(id) not found")
                    return
                }
                task.todo = todo
                task.taskDescription = description
                task.completed = completed
                task.userId = Int32(userId)
                task.date = date
                
                try persistentContainer.viewContext.save()
                refreshTasks()
            } catch {
                print("Failed to update task: \(error.localizedDescription)")
            }
        }
    
    func deleteTask(with item: TaskItem) {
        persistentContainer.viewContext.delete(item)
        do {
            try persistentContainer.viewContext.save()
            refreshTasks()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed do save context: \(error.localizedDescription)")
        }
    }
}
