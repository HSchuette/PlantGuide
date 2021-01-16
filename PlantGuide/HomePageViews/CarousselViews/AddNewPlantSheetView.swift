//
//  AddNewPlantSheetView.swift
//  PlantGuide
//
//  Created by (non work) on 15.11.20.
//

import SwiftUI

struct AddNewPlantSheetView: View {
    
    let plantTypes = plantData.map { $0.name }
    
    let plantLight = ["smoke.fill", "cloud.sun.fill", "sun.max.fill"]
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment (\.presentationMode) var presentationMode
    
    @State var plantID: String = UUID().uuidString
    @State var plantName = ""
    @State var selectedPlantTypeIndex: Int = 0
    @State var selectedPhotoPath = ""
    @State var selectedLightIndex = 1
    @State var sliderLightIndex = 0.0
    @State var waterBool = false
    @State var waterDate = Date()
    @State var humidityBool = false
    
    @State var isRecursive = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color(.systemGray6), Color(.secondarySystemBackground)]),startPoint: .top, endPoint: .bottom)
                        .foregroundColor(Color(.systemBackground))
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Spacer()
                        
                        HStack {
                            Text("Add a new plant")
                                .font(.system(size: 35))
                                .fontWeight(.bold)
                                .kerning(-2)
                                
                            
                            Spacer()
                        }.padding(25)
                    }
                    
                    VStack {
                        Rectangle()
                            .fill(Color(.systemGray4))
                            .cornerRadius(2)
                            .frame(width: 50, height: 5)
                            .padding(10)
                        
                        Spacer()
                    }
                    
                }.frame(height: 100)
                
                
                Form {
                    Section(header: Text("Plant Details")) {
                        TextField("Name", text: $plantName)
                            .keyboardType(.alphabet)
                        
                        Picker(selection: $selectedPlantTypeIndex, label: Text("Plant Type")) {
                            ForEach(plantData, id: \.id) { plant in
                                HStack {
                                    Image(plant.imageName)
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                    
                                    
                                    Text(plant.name)
                                }
                            }
                        }.navigationBarHidden(true)
                    }
                    
                    Section(header: Text("Photo")) {
                        storeImagePickerView(plantID: $plantID, imagePath: $selectedPhotoPath, isRecursive: $isRecursive)
                    }
                    
                    Section(header: Text("Light Details")) {
                        
                        VStack(alignment: .leading) {
                            Text("What kind of light does your plant get?")
                                .font(.callout)
                            
                            
                            
                            Picker("Room", selection: $selectedLightIndex) {
                                ForEach(0..<plantLight.count) {
                                    Image(systemName: "\(self.plantLight[$0])")
                                        .renderingMode(.original)
                                }
                            }.pickerStyle(SegmentedPickerStyle())
                        }.padding(.vertical, 5)
                        
                        VStack(alignment: .leading) {
                            Text("How much light does your plant get?")
                                .font(.callout)
                                .padding(.vertical, 5)
                            
                            HStack {
                                Image(systemName: "sun.max.fill")
                                    .renderingMode(.original)
                                    .scaleEffect(0.8)
                                
                                Slider(value: $sliderLightIndex, in: 0.0...4.0, step: 0.5)
                                    .accentColor(Color("yellow"))
                                
                                
                                Image(systemName: "sun.max.fill")
                                    .renderingMode(.original)
                                    .scaleEffect(1.2)
                                
                            }
                            
                            Text("A \(plantData[selectedPlantTypeIndex].name) needs \(plantData[selectedPlantTypeIndex].lightCategory.rawValue) to grow in optimal conditions.")
                        }.padding(.vertical, 5)
                    }
                    
                    Section(header: Text("Reminders")) {
                        VStack(alignment: .leading) {
                            Toggle(isOn: $waterBool) {
                                Text("Do you want a water reminder?")
                            }.padding(.vertical, 5)
                            .onChange(of: waterBool, perform: { value in
                                print("reminder = \(waterBool)")
                            })
                       
                            if waterBool {
                                Divider()
                                    HStack {
                                        CircleIcon(color: Color("blue"), image: "cloud.rain.fill")
                                            .padding(.trailing, 5)
                                        
                                        
                                        Text("When was the last time you watered your plant?")
                                    }
                                    
                                    DatePicker("Select Date", selection: $waterDate, displayedComponents: .date)
                                        .datePickerStyle(GraphicalDatePickerStyle())
                                        .accentColor(Color("textBlue"))
                                        .frame(maxHeight: 400)
                                .padding(.vertical, 5)
                                .animation(.none)
                                
                            } else {
                            }
                        }
//                        Leave this out until I refactore the notifications
//                        HStack {
//                            Toggle(isOn: $humidityBool) {
//                                Text("Do you want a humidification reminder?")
//                            }
//                        }
                    }
                    
                    Button(action: {
                        guard self.plantName != "" else {return}
                        let newPlant = StorePlantEntity(context: viewContext)
                        newPlant.id = self.plantID
                        newPlant.name = self.plantName
                        newPlant.type = self.plantTypes[self.selectedPlantTypeIndex]
                        newPlant.imagePath = self.selectedPhotoPath
                        newPlant.lightCategory = self.plantLight[self.selectedLightIndex]
                        newPlant.lightFactor = self.sliderLightIndex
                        newPlant.isWaterReminder = self.waterBool
                        newPlant.dateLastWatering = self.waterDate
                        newPlant.dateNextWatering = WaterReminderDateHelper.calculateWaterReminder(waterFactor: plantData[selectedPlantTypeIndex].waterFactor, lastWaterDate: waterDate)
                        newPlant.waterCategory = plantData[selectedPlantTypeIndex].waterCategory
                        newPlant.isHumidityReminder = self.humidityBool
                        newPlant.dateAdded = Date()
                        NotificationHelper.setNotification(plant: newPlant, waterFactor: plantData[selectedPlantTypeIndex].waterFactor, lastWaterDate: waterDate)
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
                }.padding(.top, -10)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .accentColor(Color("textBlue"))
    }
}

struct AddNewPlantSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewPlantSheetView()
    }
}
