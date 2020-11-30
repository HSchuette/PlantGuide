//
//  PlantCardCarousselView.swift
//  PlantGuide
//
//  Created by (non work) on 11.11.20.
//

import SwiftUI

struct PlantCardCarousselView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var detailPlant: DetailPlant
    
    @FetchRequest(
        entity: StorePlantEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \StorePlantEntity.name, ascending: false)],
        animation: .default)
    
    private var storePlants: FetchedResults<StorePlantEntity>
    
    @State private var showDetailSheet: Bool = false
    
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
            HomePageDetailView(plant: detailPlant)
                .environmentObject(DetailPlant())
        })
    }
    private func deleteItems(toDelete: StorePlantEntity) {
        withAnimation {
            let imagePaths = toDelete.imagePath
            
            print(imagePaths!)
            
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
                        withAnimation(.easeInOut(duration: 0.4)) {
                            updateAllValues(plant: plant)
                            self.showDetailSheet = true
                                }
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
                }
            }
            .padding(.bottom, 5)
        }
    }
    func updateAllValues(plant: StorePlantEntity) {
        detailPlant.id = plant.id!
        detailPlant.name = plant.name!
        detailPlant.type = plant.type!
        detailPlant.imagePath = plant.imagePath!
        detailPlant.lightCategory = plant.lightCategory!
        detailPlant.lightFactor = plant.lightFactor
        detailPlant.isWaterReminder = plant.isWaterReminder
        detailPlant.dateLastWatering = plant.dateLastWatering!
        detailPlant.dateNextWatering = plant.dateNextWatering!
        detailPlant.waterCategory = plant.waterCategory!
        detailPlant.isHumidityReminder = plant.isHumidityReminder
        detailPlant.dateAdded = plant.dateAdded!
    }
}

struct PlantCardCarousselView_Previews: PreviewProvider {
    static var previews: some View {
        PlantCardCarousselView(onEdit: Binding.constant(true), seeAll: Binding.constant(false))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(DetailPlant())
    }
}

