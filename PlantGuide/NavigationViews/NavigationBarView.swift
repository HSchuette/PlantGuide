//
//  NavigationBarView.swift
//  PlantGuide
//
//  Created by (non work) on 08.11.20.
//

import SwiftUI

struct NavigationBarView: View {
    
    @EnvironmentObject var navigationRouter: NavigationRouter
    
    var blue = Color("blue")
    var yellow = Color("yellow")
    let green = Color(red: 112/256, green: 191/256, blue: 92/256)

    var body: some View {
        ZStack {
            HStack {
                Spacer()
                Spacer()
                
                NavigationItemView(title: "Home", imageName: "house", color: blue, inputCase: .homePage)
                
                Spacer()
                
                NavigationItemView(title: "Scan", imageName: "viewfinder", color: yellow, inputCase: .scanPage)
                  
                Spacer()
                
                NavigationItemView(title: "Overview", imageName: "chart.bar", color: green, inputCase: .overViewPage)
                
                Spacer()
                Spacer()
                
            }
            
        }.padding()
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView().preferredColorScheme(.dark).environmentObject(NavigationRouter())
    }
}


struct NavigationItemView: View {
    @EnvironmentObject var navigationRouter: NavigationRouter
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var title: String = "title"
    var imageName: String = "house"
    var color: Color = Color("welcomeBlue")
    var inputCase: Page

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(.systemBackground), Color(.systemGray5)]), startPoint: .top, endPoint: .bottom)
                .frame(width: navigationRouter.currentPage != inputCase ? 60 : 120, height: 50, alignment: .center)
                .cornerRadius(25)
                .opacity(navigationRouter.currentPage != inputCase ? 0 : 0.2)
            
            RoundedRectangle(cornerRadius: 25.0)
                .frame(width: navigationRouter.currentPage != inputCase ? 60 : 120, height: 50, alignment: .center)
                .foregroundColor(color).opacity(0.2)
                .transition(.opacity)
                .opacity(navigationRouter.currentPage != inputCase ? 0 : 1)
                .shadow(color: Color(UIColor.black).opacity(colorScheme == .light ? 0.1 : 0), radius: 4, x: 5, y: 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 25.0)
                        .stroke(colorScheme == .light ? .clear : Color(.systemGray), lineWidth: 1)
                        .opacity(navigationRouter.currentPage != inputCase ? 0 : 1)
                )
            
            HStack(alignment: .center) {
                Image(systemName: imageName)
                
                Text(navigationRouter.currentPage != inputCase ? "" : title)
                    .bold()
                    .font(.caption)
                
            }
            .foregroundColor(navigationRouter.currentPage != inputCase ? Color(.label) : color)
            .padding()
            
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.5)) {
                navigationRouter.currentPage = inputCase
            }
        }
    }
}
