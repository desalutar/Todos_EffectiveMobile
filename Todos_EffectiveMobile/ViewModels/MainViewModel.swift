//
//  MainViewModel.swift
//  Todos_EffectiveMobile
//
//  Created by Ишхан Багратуни on 07.09.24.
//

import Foundation
import SwiftUI

final class MainViewModel: ObservableObject {
    var taskItems = [TaskItem]()
    @Published var isShowingEditTaskView = false
    @Published var selectedTask: TaskItem?
    
    func showEditTask(at taskIndex: Int, taskStore: TaskStore) {
        selectedTask = taskStore.tasks[taskIndex]
        isShowingEditTaskView.toggle()
    }
 
    func fetchTasks() async {
        let taskStore = TaskStore(coreDataManager: CoreDataManager())
        await taskStore.fetchTasks()
    }
    
    func editButton(for index: Int, taskStore: TaskStore) -> some View {
        Button {
            self.showEditTask(at: index, taskStore: taskStore)
        } label: {
            Label("Edit", systemImage: "pencil")
                .tint(.blue)
        }
    }
}
