//
//  ContentView.swift
//  Todos_EffectiveMobile
//
//  Created by Ишхан Багратуни on 03.09.24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var taskStore: TaskStore
    @StateObject var viewModel: MainViewModel
    
    @State var coreDM: CoreDataManager
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HeaderView(taskStore: _taskStore, coreDM: $coreDM)
                FilterButtonView()
                    .padding(.leading, 10)
                
                taskList
            }
            .background(Color(red: 242/255, green: 242/255, blue: 247/255))
            .task {
                await taskStore.fetchTasks()
            }
        }
    }
}

private extension MainView {
    var taskList: some View {
        List {
            ForEach(Array(taskStore.tasks.enumerated()), id: \.offset) { index, task in
                TaskView(taskModel: $taskStore.tasks[index], coreDM: $coreDM)
                    .swipeActions(edge: .leading) {
                        viewModel.editButton(for: index, taskStore: taskStore)
                    }
                
                    .sheet(isPresented: $viewModel.isShowingEditTaskView) {
                        if let task = viewModel.selectedTask {
                            EditTaskView(
                                isPresented: $viewModel.isShowingEditTaskView,
                                task: task,
                                coreDM: $coreDM
                            )
                        }
                    }
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    let task = taskStore.tasks[index]
                    taskStore.coreDM.deleteTask(with: task)
                    taskStore.tasks = taskStore.coreDM.getAllTasks().sorted { $0.userId > $1.userId }
                }
            }
        }
        .listRowSpacing(10)
        .padding(.top, 0)
    }
}


#Preview {
    @Previewable var viewModel = MainViewModel()
    MainView(viewModel: viewModel, coreDM: CoreDataManager())
        .environmentObject(TaskStore(coreDataManager: CoreDataManager()))
}
