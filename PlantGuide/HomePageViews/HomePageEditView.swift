//
//  HomePageEditView.swift
//  PlantGuide
//
//  Created by (non work) on 04.12.20.
//

import SwiftUI
import CoreData

struct HomePageEditView: View {
    @Environment (\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    let plantTypes = plantData.map { $0.name }
    
    let plantLight = ["smoke.fill", "cloud.sun.fill", "sun.max.fill"]
    
    @ObservedObject var detailPlant: StorePlantEntity
    
    @State var plantID: String = UUID().uuidString
    @State var plantName = ""
    @State var selectedPlantTypeIndex: Int = 0
    @State var selectedPhotoPath = ""
    @State var selectedLightIndex = 1
    @State var sliderLightIndex = 0.0
    @State var waterBool = true
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
                            Text("Edit")
                                .font(.system(size: 35))
                                .fontWeight(.bold)
                                .kerning(-2)
                                
                            
                            Spacer()
                            
                            Button(action: {
                                print("Save")
                                savePlant(plant: detailPlant)
                            }, label: {
                                HStack {
                                    Text("Save")
                                    
                                    Image(systemName: "square.and.arrow.down")
                                }
                            })
                            
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
                        }.id(UUID())
                    }
                    
                    Section(header: Text("Photo")) {
                        storeImagePickerView(image: UIImage(contentsOfFile: selectedPhotoPath), plantID: $plantID, imagePath: $selectedPhotoPath, isRecursive: $isRecursive)
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
                                        .accentColor(Color("blue"))
                                        .frame(maxHeight: 400)
                                .padding(.vertical, 5)
                                .animation(.none)
                                
                            } else {
                            }
                        }
                        
//                        HStack {
//                            Toggle(isOn: $humidityBool) {
//                                Text("Do you want a humidification reminder?")
//                            }
//                        }
                    }
                }
                .onAppear {
                    plantID = detailPlant.id!
                    plantName = detailPlant.name!
                    selectedPlantTypeIndex = plantTypes.firstIndex(of: detailPlant.type!)!
                    selectedPhotoPath = detailPlant.imagePath!
                    selectedLightIndex = plantLight.firstIndex(of: detailPlant.lightCategory!)!
                    sliderLightIndex = detailPlant.lightFactor
                    waterBool = detailPlant.isWaterReminder
                    waterDate = detailPlant.dateLastWatering!
                    humidityBool = detailPlant.isHumidityReminder
            }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .background(Color(.systemGray6))
        }
    }
    func savePlant(plant: StorePlantEntity) {
        guard self.plantName != "" else {return}
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
        fetchRequest.entity = StorePlantEntity.entity()
        fetchRequest.predicate = NSPredicate(format: "id == %@", detailPlant.id!)
        fetchRequest.fetchLimit = 1
        
        do {
            let updateContext = try viewContext.fetch(fetchRequest) as! [StorePlantEntity]
            let updateObject = updateContext[0] 
            
            print("\(updateObject)")
            
            updateObject.setValue(plantName, forKey: "name")
            updateObject.setValue(plantTypes[self.selectedPlantTypeIndex], forKey: "type")
            updateObject.setValue(selectedPhotoPath, forKey: "imagePath")
            updateObject.setValue(plantLight[self.selectedLightIndex], forKey: "lightCategory")
            updateObject.setValue(sliderLightIndex, forKey: "lightFactor")
            updateObject.setValue(waterBool, forKey: "isWaterReminder")
            updateObject.setValue(waterDate, forKey: "dateLastWatering")
            updateObject.setValue(WaterReminderDateHelper.calculateWaterReminder(waterFactor: plantData[selectedPlantTypeIndex].waterFactor, lastWaterDate: waterDate), forKey: "dateNextWatering")
            updateObject.setValue(plantData[selectedPlantTypeIndex].waterCategory, forKey: "waterCategory")
            updateObject.setValue(humidityBool, forKey: "isHumidityReminder")
            
            NotificationHelper.setNotification(plant: plant, waterFactor: plantData[selectedPlantTypeIndex].waterFactor, lastWaterDate: waterDate)
        
        } catch {
            print(error)
        }        
        do {
            try viewContext.save()
            print("Plant saved.")
            print("\(plant)")
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
        
    }
}

struct HomePageEditView_Previews: PreviewProvider {
    static let viewContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let plant = StorePlantEntity(context: viewContext)
        plant.id = UUID().uuidString
        plant.name = String("Pflanziska")
        plant.type = String("Monstera Deliciosa")
        plant.imagePath = String()
        plant.lightCategory = String("cloud.sun.fill")
        plant.lightFactor = Double(0)
        plant.isWaterReminder = Bool(true)
        plant.dateLastWatering = Date()
        plant.dateNextWatering = WaterReminderDateHelper.calculateWaterReminder(waterFactor: 1.0, lastWaterDate: Date())
        plant.waterCategory = String("water when dry")
        plant.isHumidityReminder = Bool(true)
        plant.dateAdded = Date()
        
        return HomePageEditView(detailPlant: plant)
            .preferredColorScheme(.dark)
    }
}
