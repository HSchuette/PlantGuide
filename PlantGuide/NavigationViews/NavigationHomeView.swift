//
//  NavigationHomeView.swift
//  PlantGuide
//
//  Created by (non work) on 08.11.20.
//

import SwiftUI
import CoreData

struct NavigationHomeView: View {
    @EnvironmentObject var navigationRouter: NavigationRouter
    @EnvironmentObject var selectedPlant: SelectedPlant
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var showLearnMoreSheet: Bool = false
    
    @FetchRequest(
        entity: StorePlantEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \StorePlantEntity.name, ascending: false)],
        animation: .default)
    
    private var storePlants: FetchedResults<StorePlantEntity>
    
    @State var onEdit: Bool = false
    
    var body: some View {        
        NavigationView {
            ZStack{
                VStack {
                    Spacer()
                    switch navigationRouter.currentPage {
                                case .homePage:
                                    NavigationListView(onEdit: $onEdit)
                                case .scanPage:
                                    NavigationScanView()
                                case .overViewPage:
                                    NavigationOverviewView(showLearnMoreSheet: $showLearnMoreSheet)
                            }
                    
                    Spacer()
                    
                    NavigationBarView()
                }
            }.navigationBarTitleDisplayMode(.large)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                        switch navigationRouter.currentPage {
                                    case .homePage:
                                        NavigationBarTitleView(title: "Plant Room")
                                    case .scanPage:
                                        NavigationBarTitleView(title: "Identify your Plant")
                                    case .overViewPage:
                                        NavigationBarTitleView(title: "Overview")
                                }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if navigationRouter.currentPage == .homePage {
                        EditButton(onEdit: $onEdit)
                    }
                }
            }
        }
    }
}

struct NavigationHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationHomeView()
            .environmentObject(NavigationRouter())
            .environmentObject(SelectedPlant())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}



