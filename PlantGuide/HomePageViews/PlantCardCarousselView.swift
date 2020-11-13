//
//  PlantCardCarousselView.swift
//  PlantGuide
//
//  Created by (non work) on 11.11.20.
//

import SwiftUI

struct PlantCardCarousselView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: StorePlantEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \StorePlantEntity.name, ascending: false)],
        animation: .default)
    
    private var storePlants: FetchedResults<StorePlantEntity>
    
    @State private var deleteEntitiy: StorePlantEntity? = nil
    @State private var showActionSheet: Bool = false
    
    @Binding var onEdit: Bool
    
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
        VStack {
            
            ScrollView(.horizontal, showsIndicators: true) {
                HStack {
                    ForEach(storePlants) { plant in
                        ZStack {
                            CardView(plantName: plant.name!, plantType: plant.type!, plantID: plant.id!)
                                .padding(5)
                            
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
                    }
                }
                .frame(height: 220)
                .padding(15)
            }
        }
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
}

struct PlantCardCarousselView_Previews: PreviewProvider {
    static var previews: some View {
        PlantCardCarousselView(onEdit: Binding.constant(true))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
