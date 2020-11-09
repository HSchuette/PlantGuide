//
//  SelectedPlant.swift
//  PlantGuide
//
//  Created by (non work) on 09.11.20.
//

import SwiftUI

class SelectedPlant: ObservableObject {
    
    @Published var currentPlant: PlantName = .monsteraDeliciosa
    
}

enum PlantName {
    case monsteraDeliciosa
    case rattlesnakePlant
    case zzPlant
}
