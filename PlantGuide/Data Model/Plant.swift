//
//  Plant.swift
//  PlantRoom
//
//  Created by (non work) on 10.10.20.
//

import Foundation

struct Plant: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var latin: String
    var lightCategory: Category
    var lightFactor: Int
    var waterCategory: String
    var waterFactor: Double
    var humidityCategory: String
    var humidityFactor: Int
    var compassValueStart: Double
    var compassValueEnd: Double
    var compassTwoValues: Bool
    var hygroValueMin: Double
    var hygroValueMax: Double
    var hygroText: String
    var tempCategory: String
    var tempFactor: Int
    var fertilizationCategory: String
    var fertilizationFactor: Int
    var toxicityText: String
    var wikipediaLink: String
    var description: String
    var imageName: String
    
    enum Category: String, CaseIterable, Codable, Hashable {
        case low = "low light"
        case medium = "medium light"
        case bright = "bright indirect light"
        case direct = "direct sunlight"
    }
}

struct Picture: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
}
    

