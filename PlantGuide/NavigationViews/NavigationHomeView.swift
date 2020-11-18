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
    @State var seeAll: Bool = false
    
    init() {
            // this is not the same as manipulating the proxy directly
            let appearance = UINavigationBarAppearance()
            // this overrides everything you have set up earlier.
            appearance.configureWithTransparentBackground()
            
            // this only applies to big titles
            appearance.largeTitleTextAttributes = [
                .font : UIFont.systemFont(ofSize: 35, weight: .bold),
                NSAttributedString.Key.kern: -2
            ]
            // this only applies to small titles
            appearance.titleTextAttributes = [
                .font : UIFont.systemFont(ofSize: 35, weight: .bold),
                NSAttributedString.Key.kern: -2
                
            ]
            
            //In the following two lines you make sure that you apply the style for good
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().standardAppearance = appearance
            
        }
    
    var body: some View {        
        NavigationView {
            ZStack{                                
                VStack {
                    switch navigationRouter.currentPage {
                                case .homePage:
                                    NavigationListView(onEdit: $onEdit, seeAll: $seeAll)
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



