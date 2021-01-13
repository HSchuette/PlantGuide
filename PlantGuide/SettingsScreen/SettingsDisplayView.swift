//
//  SettingsDisplayView.swift
//  PlantGuide
//
//  Created by (non work) on 10.01.21.
//

import SwiftUI

struct SettingsDisplayView: View {
    @EnvironmentObject var iconSettings : IconNames
    
    init(){
            UITableView.appearance().backgroundColor = .clear
        }
    
    var body: some View {
       
                Form {                    
                    Picker(selection: $iconSettings.currentIndex, label: Text("Icons"))
                    {
                        ForEach(0..<iconSettings.iconNames.count) {
                            Text(self.iconSettings.iconNames[$0] ?? "Default")
                            
                        }
                    }.pickerStyle(MenuPickerStyle())
                    .onReceive([self.iconSettings.currentIndex].publisher.first()) { (value) in
                        
                        let index = self.iconSettings.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
                        
                        if index != value{
                            UIApplication.shared.setAlternateIconName(self.iconSettings.iconNames[value]){ error in
                                if let error = error {
                                    print(error.localizedDescription)
                                } else {
                                    print("Alternate icon set!")
                                }
                            }
                        }
                    }
                }.background(Color("welcomeBlue"))
            
        
    }
}

struct SettingsDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsDisplayView()
            .environmentObject(IconNames())
    }
}
