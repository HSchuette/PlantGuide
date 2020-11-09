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
    @Published var waterCategory: String = "water when dry"
    @Published var waterFactor: Double = 2
    @Published var humidityCategory: String = "medium humidity"
    @Published var humidityFactor: Int = 2
    @Published var compassValueStart: Double = 0.75
    @Published var compassValueEnd: Double = 1
    @Published var compassTwoValues: Bool = true
    @Published var hygroValueMin: Double = 0.7
    @Published var hygroValueMax: Double = 0.8
    @Published var hygroText: String = "40% - 80%"
    @Published var tempCategory: String = "18-30°C"
    @Published var tempFactor: Int = 3
    @Published var fertilizationCategory: String = "every two months"
    @Published var fertilizationFactor: Int = 1
    @Published var toxicityText: String = "The foliage results in irritations for cats, dogs and humans. The fruits are edible to humans (and very tasty!)."
    @Published var wikipediaLink: String = "https://en.wikipedia.org/wiki/Monstera_deliciosa"
    @Published var description: String = "Native to Central America, Monsteras became famous for their unique aesthetic and their natural leaf-holes. This eventually led to the nickname, Swiss Cheese Plant."
    @Published var imageName: String = "monsteraDeliciosa"
    
}
