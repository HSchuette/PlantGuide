//
//  ListView.swift
//  PlantGuide
//
//  Created by (non work) on 08.11.20.
//

import SwiftUI
import CoreData

struct ListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: StorePlantEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \StorePlantEntity.name, ascending: false)],
        animation: .default)
    
    private var storePlants: FetchedResults<StorePlantEntity>

    @State var showAddNewSheet = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button(action: {
                    print("Open Plant")
                    showAddNewSheet = true
                }, label: {
                    Image(systemName: "plus.circle")
                        .imageScale(.large)
                })
            }
            
            List {
                ForEach(storePlants) { plant in
                    VStack(alignment: .leading) {
                        HStack {
                            Image(uiImage: ImageStore.retrieve(imageNamed: "\(plant.id!).png") ?? UIImage(imageLiteralResourceName: "placeHolder"))
                                .resizable()
                                .frame(width: 35, height: 35)
                                .cornerRadius(5)
                            
                            Text("\(plant.name!)")
                                .bold()
                            
                            Spacer()
                            
                        }
                        Text("\(plant.type!)")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(DefaultListStyle())
            .sheet(isPresented: $showAddNewSheet) {
                AddNewPlantSheetView()
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newPlant = StorePlantEntity(context: viewContext)
            newPlant.id = String()
            newPlant.name = String("PlaceHolder")
            newPlant.type = String("Monstera")
            newPlant.imagePath = String()
            newPlant.lightCategory = String()
            newPlant.lightFactor = Double()
            newPlant.isWaterReminder = Bool()
            newPlant.dateLastWatering = Date()
            newPlant.dateNextWatering = Date()
            newPlant.isHumidityReminder = Bool()
            newPlant.dateAdded = Date()

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

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            let imagePaths = offsets.map { storePlants[$0].imagePath! }
            
            print(imagePaths)
            
            for path in imagePaths {
                ImageStore.delete(imageNamed: path)
            }
            
            offsets.map { storePlants[$0] }.forEach(viewContext.delete)

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
}

struct ListView_Previews: PreviewProvider {    
    static var previews: some View {
        ListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        
    }
}
