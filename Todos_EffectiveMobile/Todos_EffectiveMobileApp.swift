//
//  Todos_EffectiveMobileApp.swift
//  Todos_EffectiveMobile
//
//  Created by Ишхан Багратуни on 03.09.24.
//

import SwiftUI

@main
struct Todos_EffectiveMobileApp: App {
    let viewModel = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: viewModel, coreDM: CoreDataManager())
                .environmentObject(TaskStore(coreDataManager: CoreDataManager()))
        }
    }
}
