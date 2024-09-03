//
//  PickerView.swift
//  Todos_EffectiveMobile
//
//  Created by Ишхан Багратуни on 03.09.24.
//

import SwiftUI

struct PickerView: View {
    @Binding var selectedPicker: Int
    @Binding var pickerNames: [String]
    var body: some View {
        Picker(selection: $selectedPicker) {
            ForEach(0..<pickerNames.count, id: \.self) { index in
                Text(pickerNames[index])
            }
        } label: {
            
        }
        .pickerStyle(.segmented)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView(selectedPicker: .constant(0), pickerNames: .constant(["All", "Closed", "Open"]))
    }
}
