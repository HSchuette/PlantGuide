//
//  InstagramHandleView.swift
//  PlantGuide
//
//  Created by (non work) on 18.10.20.
//

import SwiftUI

struct InstagramHandleView: View {
    
    @State private var showActionSheet: Bool = false
    
    var actionSheet: ActionSheet {
        ActionSheet(
         title: Text("Leave Plant Room?"),
         message: Text("This app is trying to open an app outside of Plant Room. Are you sure you want to open it?"),
            buttons:[
                .default(Text("Open Instagram")){
                    instaButtonPressed()
                },
                .cancel()
        ])
    }
    
    var body: some View {
        Button(action: {
            self.showActionSheet = true
        }) {
            HStack{
                Spacer()
                
                Text("by @terra.botanika")
                    .font(.caption)
                
                Image("instaLogo")
                    .resizable()
                    .scaledToFit()
                    .padding(.leading, -5)

            }.frame(height: 20)
        }.actionSheet(isPresented: self.$showActionSheet, content: {
            actionSheet
        })
    }
}

struct InstagramHandleView_Previews: PreviewProvider {
    static var previews: some View {
        InstagramHandleView()
    }
}

func instaButtonPressed() {
    let screenName =  "terra.botanika"

        let appURL = URL(string:  "instagram://user?username=\(screenName)")
        let webURL = URL(string:  "https://instagram.com/\(screenName)")

    if UIApplication.shared.canOpenURL(appURL!) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(appURL!)
            }
        } else {
            //redirect to safari because the user doesn't have Instagram
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(webURL!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(webURL!)
            }
        }
}
