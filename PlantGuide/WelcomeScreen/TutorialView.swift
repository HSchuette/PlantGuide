//
//  TutorialView.swift
//  PlantGuide
//
//  Created by (non work) on 09.01.21.
//

import SwiftUI

struct TutorialView: View {
    var stage: Int = 1
    
    var body: some View {
        VStack {

            Spacer()
            Spacer()
            
            VStack {
                if stage == 1 {
                TutorialText(textTitle: "Home", textBody: "Take a picture of your plant and add them to your collection. Get reminded about your watering schedule.")
                    
                } else if stage == 2 {
                    TutorialText(textTitle: "Scan", textBody: "Take a picture of your plant and let a machine learning algorithm identify your house plant.")
                        
                } else if stage == 3 {
                    TutorialText(textTitle: "Overview", textBody: "Get a quick overview of the needs of your favourite plant or make a deep dive read the most important information.")
                        
                }
                Spacer()
            }.frame(height: 150)
            
            Spacer()
            
            HStack {
                Spacer()
                Spacer()
                
                FakeNavigationItemView(title: "Home", imageName: "house", color: Color(.white), small: stage == 1 ? false : true)
                                
                Spacer()
                
                FakeNavigationItemView(title: "Scan", imageName: "viewfinder", color: Color(.white), small: stage == 2 ? false : true)
                
                Spacer()
                
                FakeNavigationItemView(title: "Overview", imageName: "chart.bar", color: Color(.white), small: stage == 3 ? false : true)
                
                Spacer()
                Spacer()
            }
            
            Spacer()
        }.frame(height: 400)
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
            .preferredColorScheme(.dark)
    }
}

struct TutorialText: View {
    var textTitle = String("Home")
    var textBody = String("blahblahblahblah")
    
    var body: some View {
        VStack {
            Text(textTitle)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
                .padding(.bottom, 5)
                .multilineTextAlignment(.leading)
        
            Text(textBody)
                .foregroundColor(.white)
                .padding(.horizontal, 35)
                .multilineTextAlignment(.leading)
        }.transition(.moveInOut)
    }
}


struct FakeNavigationItemView: View {
    
    var title: String = "title"
    var imageName: String = "house"
    var color: Color = Color("welcomeBlue")
    var small: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .frame(width: small ? 60 : 120, height: 50, alignment: .center)
                .foregroundColor(Color(.white))
                .transition(.opacity)
                .opacity(small ? 0 : 1)
                .shadow(color: Color(UIColor.black).opacity(small ? 0.1 : 0), radius: 4, x: 5, y: 5)
            
            HStack(alignment: .center) {
                Image(systemName: imageName)
                
                Text(small ? "" : title)
                    .bold()
                    .font(.caption)
                
            }.foregroundColor(small ? Color(.white) : Color("welcomeBlue"))
            .padding()
            
        }
    }
}
