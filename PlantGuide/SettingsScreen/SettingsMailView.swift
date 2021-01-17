//
//  SettingsMailView.swift
//  PlantGuide
//
//  Created by (non work) on 14.01.21.
//

import SwiftUI
import MessageUI

struct SettingsMailView: View {
    
    @State private var result: Result<MFMailComposeResult, Error>? = nil
    @State private var isShowingMailHandler = false
    @Binding var showAlertNoMail: Bool
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    
    let feedback = UIImpactFeedbackGenerator(style: .light)
    
    
    var body: some View {
        HStack {
            Spacer()
            
            
            Button(action: {
                self.feedback.impactOccurred()
                MFMailComposeViewController.canSendMail() ? self.isShowingMailHandler.toggle() : self.showAlertNoMail.toggle()
            }, label: {
                HStack {
                    Image(systemName: "envelope")
                    
                    Text("App Support")
                }
                
                
            })
            
            Spacer()
            
        }.sheet(isPresented: $isShowingMailHandler) {
            MailHandler(result: self.$result)
        }
        .padding()
    }
}

struct SettingsMailView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsMailView(showAlertNoMail: Binding.constant(false))
    }
}
