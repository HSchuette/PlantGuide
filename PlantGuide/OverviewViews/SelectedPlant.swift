//
//  SelectedPlant.swift
//  PlantGuide
//
//  Created by (non work) on 09.11.20.
//

import SwiftUI

class SelectedPlant: ObservableObject {
    
    @Published var id: Int = 0
    @Published var name: String = "Monstera Deliciosa"
    @Published var latin: String = "Monstera deliciosa"
    @Published var lightFactor: Int = 2
    @Published var waterFactor: Double = 2
    @Published var humidityFactor: Int = 2
    @Published var description: String = "Native to Central America, Monsteras became famous for their unique aesthetic and their natural leaf-holes. This eventually led to the nickname, Swiss Cheese Plant."
    @Published var imageName: String = "monsteraDeliciosa"
    
}
