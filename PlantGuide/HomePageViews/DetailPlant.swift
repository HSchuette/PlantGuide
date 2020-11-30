//
//  DetailPlant.swift
//  PlantGuide
//
//  Created by (non work) on 27.11.20.
//

import SwiftUI

class DetailPlant: ObservableObject {
    
    @Published var id = String()
    @Published var name = String("PlaceHolder")
    @Published var type = String("Rattlesnake Plant")
    @Published var imagePath = String()
    @Published var lightCategory = String("cloud.sun.fill")
    @Published var lightFactor = Double(2.0)
    @Published var isWaterReminder = Bool()
    @Published var dateLastWatering = Date()
    @Published var dateNextWatering = Date()
    @Published var waterCategory = String()
    @Published var isHumidityReminder = Bool()
    @Published var dateAdded = Date()

}
