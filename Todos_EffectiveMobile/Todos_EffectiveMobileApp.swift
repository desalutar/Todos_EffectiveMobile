//
//  Todos_EffectiveMobileApp.swift
//  Todos_EffectiveMobile
//
//  Created by Ишхан Багратуни on 03.09.24.
//

import SwiftUI

@main
struct Todos_EffectiveMobileApp: App {
    let tasks = TaskStore()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(tasks)
        }
    }
}
