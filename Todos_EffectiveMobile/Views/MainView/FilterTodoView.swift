//
//  FilterTodoView.swift
//  Todos_EffectiveMobile
//
//  Created by Ишхан Багратуни on 04.09.24.
//

import SwiftUI

struct FilterButtonView: View {
    @State private var activeButtonIndex: Int? = 0
    let buttons = ["All", "Closed", "Open"]
    
    var body: some View {
        HStack(spacing: 25) {
            ForEach(buttons.indices, id: \.self) { index in
                Button(action: {
                    self.activeButtonIndex = index
                }) {
                    Text(buttons[index])
                        .foregroundColor(activeButtonIndex == index ? .blue : .gray)
                }
                
                if activeButtonIndex == index && index != buttons.count - 1 {
                    Divider()
                }
            }
            Spacer()
        }
        .padding(10)
        .frame(height: 40)
    }
}

#Preview {
    FilterButtonView()
}
