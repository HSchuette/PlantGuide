//
//  PlantCardCarousselView.swift
//  PlantGuide
//
//  Created by (non work) on 11.11.20.
//

import SwiftUI

struct PlantCardCarousselView: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var selectedPlant: SelectedPlant
    
    @FetchRequest(
        entity: StorePlantEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \StorePlantEntity.name, ascending: false)],
        animation: .default)
    
    var storePlants: FetchedResults<StorePlantEntity>
    
    @State var showDetailSheet = false
    @State var detailPlantID: String = ""
    
    @State private var deleteEntitiy: StorePlantEntity? = nil
    @State private var showActionSheet: Bool = false
    
    @Binding var onEdit: Bool
    @Binding var seeAll: Bool
    
    let feedback = UIImpactFeedbackGenerator(style: .light)
    
    var actionSheet: ActionSheet {
        ActionSheet(
            title: Text("Are you sure you want to delete this plant?"),
            buttons:[
                .destructive(Text("Delete")){
                    deleteItems(toDelete: deleteEntitiy!)
                },
                .cancel()
            ])
    }
    
    var body: some View {
        Group {
            if seeAll == true {
                ScrollView(.vertical, showsIndicators: true) {
                    LazyVGrid(columns: [
                        GridItem(.fixed(160)),
                        GridItem(.fixed(160))
                    ], alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0, content: {
                        completeGridView()
                    })
                }
            } else {
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack {
                        completeGridView()
                    }.padding(.leading, 25)
                }
            }
        }.sheet(isPresented: $showDetailSheet, content: {
            HomePageDetailView(detailPlantID: $detailPlantID)
                .environmentObject(SelectedPlant())
        })
    }
    private func deleteItems(toDelete: StorePlantEntity) {
        withAnimation {
            let imagePaths = toDelete.imagePath
            
            print(imagePaths!)
            NotificationHelper.cancelNotification(plant: toDelete)
            
            ImageStore.delete(imageNamed: imagePaths!)
            
            
            viewContext.delete(toDelete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func completeGridView() -> some View {
        ForEach(storePlants, id: \.self) { plant in
            ZStack {
                CardView(plantName: plant.name!, plantType: plant.type!, plantID: plant.id!)
                    .onTapGesture {
                        detailPlantID = plant.id!
                        print("\(plant)")
                        showDetailSheet.toggle()
                    }

                if onEdit == true {
                    DeleteButton()                        
                        .onTapGesture(perform: {
                            self.deleteEntitiy = plant
                            withAnimation(Animation.easeInOut.delay(1)) {
                                self.showActionSheet = true
                                self.feedback.impactOccurred()
                            }
                        })
                        .actionSheet(isPresented: $showActionSheet, content: {
                                        self.actionSheet })
                        .padding(.top, -16)
                        .padding(.trailing, seeAll ? 0 : -4)
                }
            }
            .padding(.bottom, 5)
        }
    }
}

struct PlantCardCarousselView_Previews: PreviewProvider {
    static var previews: some View {
        PlantCardCarousselView(onEdit: Binding.constant(true), seeAll: Binding.constant(false))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

