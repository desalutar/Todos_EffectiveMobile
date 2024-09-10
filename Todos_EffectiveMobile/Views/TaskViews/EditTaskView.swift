//
//  EditTaskView.swift
//  Todos_EffectiveMobile
//
//  Created by Ишхан Багратуни on 04.09.24.
//

import SwiftUI



struct EditTaskView: View {
    @EnvironmentObject var taskStore: TaskStore
    @State private var editedTask: TaskItem
    @Binding var isPresented: Bool
    @Binding var coreDM: CoreDataManager
    
    init(isPresented: Binding<Bool>, task: TaskItem, coreDM: Binding<CoreDataManager>) {
        self._isPresented = isPresented
        self._editedTask = State(initialValue: task)
        self._coreDM = coreDM
    }
    
    var body: some View {
        VStack {
            TaskFormView(
                taskName: Binding(
                    get: { editedTask.todo ?? "" },
                    set: { editedTask.todo = $0 }
                ),
                taskDescription: Binding(
                    get: { editedTask.taskDescription ?? "" },
                    set: { editedTask.taskDescription = $0 }
                ),
                taskDate: $editedTask.date
            )
            Button {
//                if let index = taskStore.tasks.firstIndex(where: { $0.id == editedTask.id }) {
//                    taskStore.tasks[index] = editedTask
//                    isPresented.toggle()
//                }
                coreDM.updateTask(
                    id: Int(editedTask.id),
                    todo: editedTask.todo ?? "",
                    description: editedTask.taskDescription,
                    completed: editedTask.completed,
                    userId: Int(editedTask.userId),
                    date: editedTask.date
                )
                isPresented.toggle()
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 135, height: 50)
                        .foregroundStyle(.blue.opacity(0.2))
                    Text("Save changes")
                        .foregroundStyle(.blue)
                }
            }
            Spacer()
        }
    }
}
