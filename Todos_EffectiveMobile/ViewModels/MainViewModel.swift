//
//  MainViewModel.swift
//  Todos_EffectiveMobile
//
//  Created by Ишхан Багратуни on 07.09.24.
//

import Foundation
import SwiftUI

final class MainViewModel: ObservableObject {
    @Published var isShowingEditTaskView = false
    @Published var selectedTask: TaskModel?
    
    @MainActor func showEditTask(at taskIndex: Int, taskStore: TaskStore) {
        selectedTask = taskStore.tasks[taskIndex]
        isShowingEditTaskView.toggle()
    }
    
    @MainActor func deleteTask(at index: Int, from taskStore: TaskStore) {
        taskStore.tasks.remove(at: index)
    }
 
    func fetchTasks() async {
        let taskStore = TaskStore()
        await taskStore.fetchTasks()
    }
    
    @MainActor
    func editButton(for index: Int, taskStore: TaskStore) -> some View {
        Button {
            self.showEditTask(at: index, taskStore: taskStore)
        } label: {
            Label("Edit", systemImage: "pencil")
                .tint(.blue)
        }
    }
}
