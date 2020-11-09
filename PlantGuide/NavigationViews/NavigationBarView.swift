//
//  NavigationBarView.swift
//  PlantGuide
//
//  Created by (non work) on 08.11.20.
//

import SwiftUI

struct NavigationBarView: View {
    
    @EnvironmentObject var navigationRouter: NavigationRouter
    
    var blue = Color("welcomeBlue")
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
            
        }
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView().environmentObject(NavigationRouter())
    }
}


struct NavigationItemView: View {
    @EnvironmentObject var navigationRouter: NavigationRouter
    
    var title: String = "title"
    var imageName: String = "house"
    var color: Color = Color("welcomeBlue")
    var inputCase: Page

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .frame(width: navigationRouter.currentPage != inputCase ? 0 : 120, height: 50, alignment: .center)
                .foregroundColor(color).opacity(0.2)
                .transition(.opacity)
            
            HStack(alignment: .center) {
                Image(systemName: imageName)
                
                Text(navigationRouter.currentPage != inputCase ? "" : title)
                    .bold()
                    .font(.caption)
                
            }
            .foregroundColor(navigationRouter.currentPage != inputCase ? .black : color)
            .padding()
        }.onTapGesture {
            withAnimation(.easeInOut(duration: 0.5)) {
                navigationRouter.currentPage = inputCase
            }
        }
    }
}
