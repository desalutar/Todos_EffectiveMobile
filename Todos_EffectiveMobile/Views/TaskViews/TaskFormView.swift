//
//  CreateNewTaskView.swift
//  Todos_EffectiveMobile
//
//  Created by Ишхан Багратуни on 04.09.24.
//

import SwiftUI

struct TaskFormView: View {
    @Binding var taskName: String
    @Binding var taskDescription: String
    @Binding var taskDate: Date?
    
    var body: some View {
        VStack(spacing: 15) {
            TextField("Enter title", text: $taskName)
                .textFieldStyle(.roundedBorder)
                .frame(width: 350)
            
            TextEditor(text: $taskDescription)
                .frame(width: 350, height: 200)
                .background(Color(red: 242/255, green: 242/255, blue: 247/255))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(red: 243/255, green: 242/255, blue: 247/255), lineWidth: 3)
                }
            
            DatePicker("Selected task date",
                       selection: .init(
                        get: { self.taskDate ?? Date() },
                        set: { self.taskDate = $0 }
                       ))
            .labelsHidden()
            .datePickerStyle(.wheel)
        }.padding(.top, 15)
    }
}

