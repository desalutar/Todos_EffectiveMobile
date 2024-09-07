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
    
    var body: some View {
        VStack {
            TaskFormView(taskName: $taskName, 
                         taskDescription: $taskDescription,
                         taskDate: $taskDate
            )
            Button {
                let newTask = TaskModel(
                    id: taskStore.tasks.count + 1,
                    todo: taskName,
                    description: taskDescription,
                    completed: true,
                    userId: taskStore.tasks.count + 1,
                    date: taskDate
                )
                taskStore.tasks.append(newTask)
                print("Task added: \(newTask)")
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
