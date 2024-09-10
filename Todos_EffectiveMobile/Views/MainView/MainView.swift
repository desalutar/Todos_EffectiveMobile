//
//  ContentView.swift
//  Todos_EffectiveMobile
//
//  Created by Ишхан Багратуни on 03.09.24.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var taskStore: TaskStore
    @StateObject var viewModel: MainViewModel
    @State private var pickerNames = ["All", "Open", "Closed"]
    
    @State var coreDM: CoreDataManager
    @State private var taskItems: [TaskItem] = [TaskItem]()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HeaderView(taskStore: _taskStore, coreDM: $coreDM)
                FilterButtonView()
                    .padding(.leading, 10)
                
                taskList
            }
            .background(Color(red: 242/255, green: 242/255, blue: 247/255))
            .task(priority: .background, {
                await taskStore.fetchTasks()
            })
            .onAppear {
                taskItems = coreDM.getAllTasks().sorted { $0.userId > $1.userId }
            }
        }
    }
}

private extension MainView {
    var taskList: some View {
        List {
            ForEach(Array(taskItems.enumerated()), id: \.offset) { index, task in
                TaskView(taskModel: $taskItems[index], coreDM: $coreDM)
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
                            .onDisappear {
                                taskItems = coreDM.getAllTasks()
                            }
                        }
                    }
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    let task = taskItems[index]
                    coreDM.deleteTask(with: task)
                    taskItems = coreDM.getAllTasks()
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
