//
//  TaskView.swift
//  Todos_EffectiveMobile
//
//  Created by Ишхан Багратуни on 04.09.24.
//

import SwiftUI

struct TaskView: View {
    @Binding var taskModel: TaskModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .listRowSeparatorLeading) {
                    Text(taskModel.title)
                        .font(.title2)
                        .strikethrough(taskModel.completed ? false : true)
                    Text(taskModel.description ?? "")
                        .font(.callout)
                        .opacity(0.6)
                }
                
                Spacer()
                
                Button {
                    taskModel.completed.toggle()
                } label: {
                    Image(systemName: taskModel.completed ? "circle" : "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(taskModel.completed ? .gray : .blue)
                }
            }
            Divider()
            HStack {
                Text(taskModel.date ?? .now, formatter: dateFormatter)
                    .font(.callout)
                    .padding(.top, 10)
                    .opacity(0.5)
            }
        }.padding(9)
        
    }
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMM yyyy, HH:mm"
        return formatter
    }()
}


