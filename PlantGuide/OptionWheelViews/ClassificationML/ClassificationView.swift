//
//  ClassificationView.swift
//  PlantRoom
//
//  Created by (non work) on 10.10.20.
//

import SwiftUI
import CoreML

struct ClassificationView: View {
    
    @EnvironmentObject var selectedPlant: SelectedPlant

    @Binding var image: UIImage?
    
    @State private var classificationLabel: Array = [999]
    
    private func performImageClassification(image: UIImage?) {
        
        let model = PlantGuide()
        
        guard let image = image,
            let buffer = buffer(from: image) else {
                return
        }
        
        let output = try? model.prediction(image: buffer)
        
        if let output = output {
            
            let results = output.classLabelProbs.sorted { $0.1 > $1.1 }
                .filter({$0.value > 0.25})
            
            let result: [Int] = results.map { (key, value) in
                return (Int(key) ?? Int(999))
            }
            
            classificationLabel = result
            
        }
        
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color(.systemBackground), Color(.systemGray6)]),startPoint: .top, endPoint: .bottom)
                        .foregroundColor(Color(.systemBackground))
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Rectangle()
                            .fill(Color(.systemGray4))
                            .cornerRadius(2)
                            .frame(width: 50, height: 5)
                            .padding(10)
                        
                        Spacer()
                    }
                    
                    VStack {
                        
                        HStack {
                            Text("Identification")
                                .font(.largeTitle)
                                .bold()
                            
                            Spacer()
                        }.padding(.vertical)
                        
                        PicturePreview(image: $image)
                            .onAppear() {
                                self.performImageClassification(image: self.image)
                        }
                        
                        Spacer()
                        
                        HStack {
                            Text("Here are your results:")
                                .fontWeight(.regular)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.top, 20)
                                .foregroundColor(Color(.systemGray))
                            
                            Spacer()
                        }.padding([.leading, .top], 15)
                                            
                        ForEach(classificationLabel, id: \.self) {x in
                            NavigationLink(destination: ClassificationPlantDetail(selected: Binding.constant(x), image: self.$image).navigationBarTitle("", displayMode: .large)
                            .navigationBarHidden(true)) {
                                
                                ResultPreview(selected: Binding.constant(x))
                                
                            }.buttonStyle(PlainButtonStyle())}

                        
                        if classificationLabel.isEmpty {
                            ZStack {
                                Rectangle()
                                    .cornerRadius(20)
                                    .foregroundColor(Color(.systemBackground))
                                
                                Text("Sadly we could not classify your houseplant sufficiently. Feel free to send us a mail with a photo of the plant so I can add it in the future.")
                                    .lineLimit(nil)
                                    .font(.caption)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding()
                            }.clipped()
                            .cornerRadius(10)
                            .frame(width: 325, height: 100)
                            .shadow(radius: 5)
                            .padding(5)
                            
                        }
                        
                        Spacer()
                    }.padding(25)
                }
            }.background(Color(.systemGray6))
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle("", displayMode: .large)
            .navigationBarHidden(true)
            
        }
    }
}

struct ClassificationView_Previews: PreviewProvider {
    static var previews: some View {
        ClassificationView(image: Binding.constant(UIImage(named: "test")))
            .environmentObject(SelectedPlant())
    }
}
