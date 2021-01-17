//
//  NavigationRouter.swift
//  PlantGuide
//
//  Created by (non work) on 09.11.20.
//

import SwiftUI

class NavigationRouter: ObservableObject {
    
    @Published var currentPage: Page = .homePage
    
}

enum Page {
    case homePage
    case scanPage
    case overViewPage
}
