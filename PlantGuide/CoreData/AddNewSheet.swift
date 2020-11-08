//
//  AddNewSheet.swift
//  PlantGuide
//
//  Created by (non work) on 08.11.20.
//

import SwiftUI

struct AddNewSheet: View {
    
    let plantTypes = ["Monstera Deliciosa", "Rattlesnake Plant", "ZZ Plant", "Snake Plant", "Peace Lily"]
    
    let plantRooms = ["Kitchen", "Bedroom", "Bathroom"]
        
    @Environment(\.managedObjectContext) private var viewContext
    @Environment (\.presentationMode) var presentationMode
    
    @State var plantID: String = UUID().uuidString
    @State var plantName = ""
    @State var selectedPlantIndex = 1
    @State var selectedPhotoPath = ""
    @State var selectedRoomIndex = 1
    
    var body: some View {
        NavigationView {
                    Form {
                        Section(header: Text("Plant Details")) {
                            TextField("Name", text: $plantName)
                                .keyboardType(.alphabet)
                            
                            Picker(selection: $selectedPlantIndex, label: Text("Plant Type")) {
                                ForEach(0 ..< plantTypes.count) {
                                        Text(self.plantTypes[$0]).tag($0)
                                }
                            }
                        }
                        
                        Section(header: Text("Photo")) {
                            storeImagePickerView(plantID: $plantID, imagePath: $selectedPhotoPath)
                        }
                        
                        Section(header: Text("Room")) {
                            Picker("Room", selection: $selectedRoomIndex) {
                                ForEach(0..<plantRooms.count) {
                                                        Text(self.plantRooms[$0])
                                                    }
                            }.pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Button(action: {
                            guard self.plantName != "" else {return}
                            let newPlant = StorePlantEntity(context: viewContext)
                            newPlant.id = self.plantID
                            newPlant.name = self.plantName
                            newPlant.type = self.plantTypes[self.selectedPlantIndex]
                            newPlant.imagePath = self.selectedPhotoPath
                            newPlant.room = self.plantRooms[self.selectedRoomIndex]
                            do {
                                try viewContext.save()
                                print("Plant saved.")
                                print("AddNewSheet_Path\(selectedPhotoPath)")
                                presentationMode.wrappedValue.dismiss()
                                } catch {
                                    print(error.localizedDescription)
                                }
                        }) {
                            Text("Add Plant")
                        }
                    }
                        .navigationTitle("Add a new Plant")
                }
    }
}

struct AddNewSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddNewSheet()
    }
}
