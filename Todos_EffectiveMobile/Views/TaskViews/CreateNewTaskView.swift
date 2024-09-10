//
//  CreateNewTaskView.swift
//  Todos_EffectiveMobile
//
//  Created by Ишхан Багратуни on 04.09.24.
//

import SwiftUI

struct CreateNewTaskView: View {
    @State var taskStore: TaskStore
    @State private var taskName = ""
    @State private var taskDescription = ""
    @State private var taskDate: Date? = Date()
    @Binding var isPresented: Bool
    @Binding var coreDM: CoreDataManager
    
    var body: some View {
        VStack {
            TaskFormView(taskName: $taskName,
                         taskDescription: $taskDescription,
                         taskDate: $taskDate
            )
            Button {
                let newId = (taskStore.tasks.map { Int($0.userId) }.max() ?? 0) + 1
                 
                 // Сохранение новой задачи
                 taskStore.coreDataManager.saveTask(
                     id: newId,
                     todo: taskName,
                     description: taskDescription,
                     completed: false,
                     userId: newId,
                     date: taskDate
                 )
                 
                 // Обновляем задачи
                 coreDM.refreshTasks()
                 
                 // Очистка полей и закрытие представления
                 taskName = ""
                 taskDescription = ""
                 isPresented.toggle()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 135, height: 50)
                        .foregroundStyle(.blue.opacity(0.2))
                    Text("Add Task")
                        .foregroundStyle(.blue)
                }
            }
            Spacer()
        }
    }
}
