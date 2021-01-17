//
//  SettingsDisplayView.swift
//  PlantGuide
//
//  Created by (non work) on 10.01.21.
//

import SwiftUI

struct SettingsDisplayView: View {
    @EnvironmentObject var iconSettings : IconNames
    
    @State var showAlertUpgrade: Bool = false
    @State var showAlertNoMail: Bool = false
    
    var body: some View {
       
        NavigationView {
            
            VStack {
                HStack {
                    Text("Settings")
                        .font(.system(size: 35))
                        .fontWeight(.bold)
                        .kerning(-2)
                        
                    
                    Spacer()
                }.padding([.leading, .top], 25)
                
                Form {
                    
                    Section(header: Text("Plant Details")) {
                        Picker("App Icon", selection: $iconSettings.currentIndex)
                                {
                                    ForEach(0..<iconSettings.iconNames.count) { index in
                                        HStack {
                                            Image(uiImage: UIImage(named: self.iconSettings.iconNames[index] ?? "AppIcon") ?? UIImage())
                                                .resizable()                                            
                                            .frame(width: 50, height: 50)
                                            .cornerRadius(6)
                                                .padding(.trailing)
                                            
                                            Text(self.iconSettings.iconNames[index] ?? "Default")
                                        }
                                        
                                    }
                                    
                                }.pickerStyle(DefaultPickerStyle())
                                .disabled(!UserDefaults.standard.bool(forKey: "com.example.PlantGuide.IAP.plantRoomPlus"))
                        .onReceive([self.iconSettings.currentIndex].publisher.first()) { (value) in
                                                
                                                let index = self.iconSettings.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
                                                
                                                if index != value{
                                                    UIApplication.shared.setAlternateIconName(self.iconSettings.iconNames[value]){ error in
                                                        if let error = error {
                                                            print(error.localizedDescription)
                                                        } else {
                                                            print("Success!")
                                                        }
                                                    }
                                                }
                                                
                                            }
                    }
                    Section(header: Text("Contact")) {
                        SettingsMailView(showAlertNoMail: $showAlertNoMail)
                    }
                    
                }
                
                Spacer()
                
            }
            .edgesIgnoringSafeArea(.all)
            .background(Color(.systemGray6))
            .navigationBarHidden(true)
        }
        .frame(height: 450)
        .alert(isPresented: self.$showAlertUpgrade, content: {
            Alert(title: Text("Error"), message: Text("Looks like you haven't upgraded to Plant Room Plus yet. Upgrade now and customize your App Icon!"))
        })
        .alert(isPresented: self.$showAlertNoMail) {
            Alert(title: Text("Error"), message: Text("It seems that you haven't set up an e-mail account on your device yet."))
        }
    }
}

struct SettingsDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsDisplayView()
            .environmentObject(IconNames())
    }
}
