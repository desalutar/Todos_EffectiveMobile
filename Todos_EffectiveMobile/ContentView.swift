//
//  ContentView.swift
//  Todos_EffectiveMobile
//
//  Created by Ишхан Багратуни on 03.09.24.
//

import SwiftUI

struct ContentView: View {
    var pickerNames = ["All", "Open", "Closed"]
    @State private var selectedPicker = 0
    @State private var tables = [TaskView()]
    var body: some View {
        NavigationStack {
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
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 125, height: 50)
                            .foregroundStyle(.blue.opacity(0.2))
                        Label("New task", systemImage: "plus")
                            .foregroundStyle(.blue)
                    }
                }
            }.padding()
            Picker(selection: $selectedPicker) {
                ForEach(0..<pickerNames.count, id: \.self) { index in
                    Text(pickerNames[index])
                }
            } label: {
                
            }
            .pickerStyle(.segmented)
            
            .padding()


            List {
                TaskView()
            }
        }
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
        }.padding()
        
    }
}

#Preview {
    ContentView()
}
