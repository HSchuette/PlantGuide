//
//  PlantGuideApp.swift
//  PlantGuide
//
//  Created by (non work) on 15.10.20.
//

import SwiftUI

@main
struct PlantGuideApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView(selected: nil, lightMeter: nil, waterMeter: nil, humidityMeter: nil, learnMore: false, isMenuOpen: false)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
