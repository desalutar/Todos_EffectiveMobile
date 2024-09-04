//
//  ContentView.swift
//  Todos_EffectiveMobile
//
//  Created by Ишхан Багратуни on 03.09.24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var taskStore: TaskStore
    @State private var pickerNames = ["All", "Open", "Closed"]
    @State private var isShowingEditTaskView = false
    @State private var selectedTask: TaskModel?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HeaderView(taskStore: _taskStore)
                FilterButtonView()
                    .padding(.leading, 10)
                NavigationStack {
                    List {
                        ForEach(taskStore.tasks.indices, id: \.self) { task in
                            TaskView(taskModel: $taskStore.tasks[task])
                                .swipeActions(edge: .leading) {
                                    Button {
                                        self.selectedTask = taskStore.tasks[task]
                                        self.isShowingEditTaskView = true
                                    } label: {
                                        Label("Edit", systemImage: "pencil")
                                            .tint(.blue)
                                    }
                                }
                                .sheet(isPresented: $isShowingEditTaskView) {
                                    EditTaskView(isPresented: $isShowingEditTaskView, task: self.taskStore.tasks[task])
                                }
                        }
                        .onDelete(perform: deleteItems(at:))
                    }
                    .listRowSpacing(10)
                    .padding(.top, 0)
                }
            }
            .background(Color(red: 242/255, green: 242/255, blue: 247/255))
        }
    }
    func deleteItems(at offsets: IndexSet) {
        taskStore.tasks.remove(atOffsets: offsets)
    }
}

#Preview {
    MainView()
        .environmentObject(TaskStore())
}
