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
    @State private var pickerNames = ["All", "Open", "Closed"]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HeaderView(taskStore: _taskStore)
                FilterButtonView()
                    .padding(.leading, 10)
                
                taskList
            }
            .background(Color(red: 242/255, green: 242/255, blue: 247/255))
            .task(priority: .background, {
                await taskStore.fetchTasks()
            })
        }
    }
}

private extension MainView {
    var taskList: some View {
        List {
            if taskStore.isLoading {
                ProgressView()
            } else {
                ForEach(Array(taskStore.tasks.enumerated()), id: \.offset) { index, task in
                        TaskView(taskModel: $taskStore.tasks[index])
                            .swipeActions(edge: .leading) {
                                viewModel.editButton(for: index, taskStore: taskStore)
                            }
                    
                            .sheet(isPresented: $viewModel.isShowingEditTaskView) {
                                if let task = viewModel.selectedTask {
                                    EditTaskView(isPresented: $viewModel.isShowingEditTaskView, task: task)
                                }
                            }
                    }
                .onDelete { indexSet in
                    viewModel.deleteTask(at: indexSet.first!,
                                         from: taskStore)
                }
            }
        }
        .listRowSpacing(10)
        .padding(.top, 0)
    }
}

#Preview {
    @Previewable var viewModel = MainViewModel()
    MainView(viewModel: viewModel)
        .environmentObject(TaskStore())
}
