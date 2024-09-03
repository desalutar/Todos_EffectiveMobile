//
//  ContentView.swift
//  Todos_EffectiveMobile
//
//  Created by Ишхан Багратуни on 03.09.24.
//

import SwiftUI

struct ContentView: View {
    @State private var pickerNames = ["All", "Open", "Closed"]
    @State private var selectedPicker = 0
    @State private var tables = [TaskView(), TaskView()]
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HeaderView()
                    
                PickerView(selectedPicker: $selectedPicker,
                           pickerNames: $pickerNames)
                List {
                    ForEach(0..<tables.count, id: \.self) { table in
                        TaskView()
                    }.onDelete(perform: deleteItems(at:))
                }.listRowSpacing(10)
                    .padding(.top, 0)
            }
            .background(Color(red: 242/255, green: 242/255, blue: 247/255))
        }
    }
    func deleteItems(at offsets: IndexSet) {
        tables.remove(atOffsets: offsets)
    }
}

struct TaskView: View {
    @State var isCompleted = false
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .listRowSeparatorLeading) {
                    Text("title")
                        .font(.title2)
                        .strikethrough(isCompleted ? false : true)
                    Text("description")
                        .font(.callout)
                        .opacity(0.6)
                }
                
                Spacer()
                
                Button {
                    isCompleted.toggle()
                } label: {
                    Image(systemName: isCompleted ? "circle" : "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(isCompleted ? .gray : .blue)
                }
            }
            Divider()
            HStack {
                Text("Today ")
                    .font(.callout)
                    .padding(.top, 10)
                    .opacity(0.5)
                Text("09:15AM - 11:15AM")
                    .font(.callout)
                    .padding(.top, 10)
                    .opacity(0.3)
                
            }
        }.padding(9)
        
    }
}

#Preview {
    ContentView()
}
