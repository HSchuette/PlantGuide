//
//  NavigationBarView.swift
//  PlantGuide
//
//  Created by (non work) on 08.11.20.
//

import SwiftUI

struct NavigationBarView: View {
    
    @Binding var navigationSelection: String
    
    var blue = Color("welcomeBlue")
    var yellow = Color("yellow")
    let green = Color(red: 112/256, green: 191/256, blue: 92/256)

    var body: some View {
        ZStack {
            HStack {
                Spacer()
                Spacer()
                
                NavigationItemView(navigationSelection: $navigationSelection, title: "Home", imageName: "house", color: blue)
                
                Spacer()
                
                NavigationItemView(navigationSelection: $navigationSelection, title: "Scan", imageName: "viewfinder", color: yellow)
                  
                Spacer()
                
                NavigationItemView(navigationSelection: $navigationSelection, title: "Overview", imageName: "chart.bar", color: green)
                
                Spacer()
                Spacer()
                
            }
            
        }
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView(navigationSelection: Binding.constant("Home"))
    }
}


struct NavigationItemView: View {
    @Binding var navigationSelection: String
    
    var title: String = "title"
    var imageName: String = "house"
    var color: Color = Color("welcomeBlue")

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .frame(width: navigationSelection != title ? 0 : 120, height: 50, alignment: .center)
                .foregroundColor(color).opacity(0.2)
                .transition(.opacity)
            
            HStack(alignment: .center) {
                Image(systemName: imageName)
                
                Text(navigationSelection != title ? "" : title)
                    .bold()
                    .font(.caption)
                
            }
            .foregroundColor(navigationSelection != title ? .black : color)
            .padding()
        }.onTapGesture {
            withAnimation(.easeInOut(duration: 0.5)) {
                navigationSelection = title
            }
        }
    }
}
