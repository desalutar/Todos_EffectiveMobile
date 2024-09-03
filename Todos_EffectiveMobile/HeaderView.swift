//
//  HeaderView.swift
//  Todos_EffectiveMobile
//
//  Created by Ишхан Багратуни on 03.09.24.
//

import SwiftUI

struct HeaderView: View {
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
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 135, height: 50)
                        .foregroundStyle(.blue.opacity(0.2))
                    Label("New task", systemImage: "plus")
                        .foregroundStyle(.blue)
                }
            }
        }.padding()
    }
}

#Preview {
    HeaderView()
}
