//
//  CompleteScanView.swift
//  PlantGuide
//
//  Created by (non work) on 10.11.20.
//

import SwiftUI

struct NavigationScanView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var selectedPlant: SelectedPlant
    
    @State var classificationLabel: Array = [999]
    @State private var showClassificationResult: Bool = false
    
    @State private var isStoreImagePickerVisible: Bool = false
    @State private var showImageSelector: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    @State var image: UIImage?
    @Binding var plantID: String
    @Binding var imagePath: String
    
    @State var isRecursive: Bool = true
    
    var body: some View {
        VStack {
            Spacer()
            
            ScanPageView(image: $image)
                .onChange(of: image) { value in
                performImageClassification(image: image)
                }
            
            Spacer()
            
            
            if showClassificationResult == false {
                Text("Identify your favourite plant by snapping a picture with your phone.")
                    .font(.callout)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                
                Spacer()
                
                HStack {
                    Text("Choose your input:")
                        .font(.callout)
                        .fontWeight(.regular)
                        .foregroundColor(Color(.systemGray))
                        
                    
                    Spacer()
                }.padding()
                
                VStack {
                    Button(action: {
                        self.showImageSelector = true
                        self.sourceType = .photoLibrary
                    }, label: {
                        HStack {
                            Image(systemName: "photo.on.rectangle.angled")
                            
                            Text("Photo Library")
                        }
                        
                        
                    }).buttonStyle(CustomButtonStyle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(colorScheme == .light ? .clear : Color(.systemGray), lineWidth: 1)
                    )
                        
                    Button(action: {
                        self.showImageSelector = true
                        self.sourceType = .camera
                        
                    }, label: {
                        HStack {
                            Image(systemName: "camera")
                            
                            Text("Camera")
                        }
                    })
                    .buttonStyle(CustomButtonStyle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(colorScheme == .light ? .clear : Color(.systemGray), lineWidth: 1)
                    )
                    .padding(5)
                    .sheet(isPresented: $showImageSelector) {
                        ImagePicker(image: self.$image, isStoreImagePickerVisible: self.$showImageSelector, plantID: $plantID, imagePath: $imagePath, isRecursive: $isRecursive, sourceType: self.sourceType).edgesIgnoringSafeArea(.all)
                }
                                    
                }
            } else {
                VStack {
                    HStack {
                        Text("Here are your results:")
                            .font(.callout)
                            .fontWeight(.regular)
                            .foregroundColor(Color(.systemGray))
                        
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation(.default) {
                                showClassificationResult = false
                                image = nil
                                classificationLabel = [999]
                            }
                            
                        }, label: {
                            Text("Restart")
                                .font(.subheadline)
                            
                            Image(systemName: "arrow.uturn.backward")
                                .font(.subheadline)
                        })
                        
                    }.padding()
                    
                    ScrollView {
                        ScanResultPreview(classificationLabel: $classificationLabel)
                    }.frame(height: 210)
                }
            }
            Spacer()
            
        }.padding(.horizontal, 25)
    }
    private func performImageClassification(image: UIImage?) {
        
        let model = PlantGuide()
        
        guard let image = image,
            let buffer = buffer(from: image) else {
                return
        }
        
        let output = try? model.prediction(image: buffer)
        
        print("\(String(describing: output))")
        
        if let output = output {
            
            let results = output.classLabelProbs.sorted { $0.1 > $1.1 }
                .filter({$0.value > 0.25})
            
            let result: [Int] = results.map { (key, value) in
                return (Int(key) ?? Int(999))
            }
            print("Classification result is id: \(result)")
            
            classificationLabel = result
            
            showClassificationResult = true
            
        }
        
    }
}

struct NavigationScanView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationScanView(plantID: Binding.constant("scan"), imagePath: Binding.constant(""))
            .environmentObject(SelectedPlant())
    }
}


struct CustomButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 250, height: 50)
            .foregroundColor(configuration.isPressed ? Color(.systemBackground) : /*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            .background(Color(configuration.isPressed ? .systemBlue : .systemBackground))
            .cornerRadius(10)
            .shadow(color: Color(UIColor.black).opacity(colorScheme == .light ? 0.2 : 0), radius: 4, x: 3, y: 3)
    }
}
