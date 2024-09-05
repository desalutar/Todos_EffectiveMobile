//
//  EditTaskView.swift
//  Todos_EffectiveMobile
//
//  Created by Ишхан Багратуни on 04.09.24.
//

import SwiftUI

struct EditTaskView: View {
    @EnvironmentObject var taskStore: TaskStore
    @State private var editedTask: TaskModel
    @Binding var isPresented: Bool
    
    init(isPresented: Binding<Bool>, task: TaskModel) {
        self._isPresented = isPresented
        self._editedTask = State(initialValue: task)
    }
    
    var body: some View {
        VStack {
            TaskFormView(
                taskName: Binding(
                    get: { editedTask.title },
                    set: { editedTask.title = $0 }
                ),
                taskDescription: Binding(
                    get: { editedTask.description ?? "" },
                    set: { editedTask.description = $0 }
                ),
                taskDate: $editedTask.date
            )
            Button {
                if let index = taskStore.tasks.firstIndex(where: { $0.id == editedTask.id }) {
                    taskStore.tasks[index] = editedTask
                }
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

