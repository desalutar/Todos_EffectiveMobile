//
//  HeaderView.swift
//  Todos_EffectiveMobile
//
//  Created by Ишхан Багратуни on 03.09.24.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var taskStore: TaskStore
    @State private var isShowNewTaskView = false
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Today's Task")
                    .font(.title)
                    .bold()
                Text("Wednesday, 11 MAY ")
                    .font(.callout)
                    .opacity(0.5)
            }
            Spacer()
            Button {
                isShowNewTaskView.toggle()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 135, height: 50)
                        .foregroundStyle(.blue.opacity(0.2))
                    Label("New task", systemImage: "plus")
                        .foregroundStyle(.blue)
                }
            }
            .sheet(isPresented: $isShowNewTaskView) { CreateNewTaskView(
                                                    taskStore: taskStore,
                                                    isPresented: $isShowNewTaskView) }
        }.padding()
    }
}

#Preview {
    HeaderView()
        .environmentObject(TaskStore())
}
