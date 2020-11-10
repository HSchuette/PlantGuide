//
//  MailView.swift
//  PlantGuide
//
//  Created by (non work) on 15.10.20.
//

import SwiftUI

import MessageUI

struct MailView: View {
    
    @State private var result: Result<MFMailComposeResult, Error>? = nil
    @State private var isShowingMailHandler = false
    @State private var alertNoMail = false
    
    let feedback = UIImpactFeedbackGenerator(style: .light)

    
    var body: some View {
        ZStack {
            
            VStack() {
                Spacer()
                
                // image
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 25.0, height: 25.0)
                    .scaledToFit()
                    .padding(.bottom, 8)
                    .foregroundColor(Color(.systemGray))
                
                Spacer()
            }.frame(width: 110, height: 140, alignment: .bottom)
            .onTapGesture {
                self.feedback.impactOccurred()
                MFMailComposeViewController.canSendMail() ? self.isShowingMailHandler.toggle() : self.alertNoMail.toggle()
            }
                //            .disabled(!MFMailComposeViewController.canSendMail())
                .sheet(isPresented: $isShowingMailHandler) {
                    MailHandler(result: self.$result)
            }
            .alert(isPresented: self.$alertNoMail) {
                Alert(title: Text("Error"), message: Text("It seems that you haven't set up an e-mail account on your device yet."))
            }
            
        }
        .frame(width: 50, height: 150.0)
        .clipped()
        .padding(.trailing, 15)
    }
}

struct MailView_Previews: PreviewProvider {
    static var previews: some View {
        MailView()
    }
}
