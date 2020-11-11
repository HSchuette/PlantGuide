//
//  CardCarousselToppingView.swift
//  PlantGuide
//
//  Created by (non work) on 11.11.20.
//

import SwiftUI
import CoreData

struct CardCarousselToppingView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var showAddNewSheet = false
    
    var body: some View {
        VStack{
            HStack {
                Text("Your Plant Gallery:")
                    .font(.callout)
                    .fontWeight(.regular)
                    .foregroundColor(Color(.systemGray))
                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeInOut) {
                        self.showAddNewSheet.toggle()
                    }
                    
                }, label: {
                    Text("Add more")
                        .font(.subheadline)
                    
                    Image(systemName: "plus.circle")
                        .font(.subheadline)
                }).sheet(isPresented: $showAddNewSheet, content: {
                    AddNewSheet()
                })
                
            }.padding(.leading, 25)
            .padding(.trailing, 40)
        }
    }
}

struct CardCarousselToppingView_Previews: PreviewProvider {
    static var previews: some View {
        CardCarousselToppingView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
