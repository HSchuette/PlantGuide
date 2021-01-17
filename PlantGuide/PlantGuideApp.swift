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
    
    @StateObject var navigationRouter = NavigationRouter()
    @StateObject var selectedPlant = SelectedPlant()
    @StateObject var storeManager = StoreManager()
    @StateObject var iconSettings = IconNames()
    
    var body: some Scene {
        WindowGroup {
            NavigationHomeView(storeManager: storeManager)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(navigationRouter)
                .environmentObject(selectedPlant)
                .environmentObject(iconSettings)
        }
    }
}
