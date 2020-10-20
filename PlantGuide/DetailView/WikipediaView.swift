//
//  WikipediaView.swift
//  PlantGuide
//
//  Created by (non work) on 20.10.20.
//

import SwiftUI
import SafariServices

struct WikipediaView: View {
    
    @Binding var selected: Int?
    @Binding var moreInfo: String?
    
    @State var showSafari: Bool = false
    @State var urlString: String = ""
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                CircleIcon(color: Color(.black), image: "text.book.closed.fill")
                    .padding(.trailing, 5)
                
                Text("Wikipedia")
                    .bold()
                    .padding()
            
                Spacer()
                
                Image(systemName: "safari")
                    .foregroundColor(.blue)
                
            }.padding(.trailing)
            .sheet(isPresented: $showSafari) {
                SafariView(url:URL(string: self.urlString)!)
            }.onTapGesture {
                self.urlString = plantData[selected!].wikipediaLink
                            
                self.showSafari = true
            }
        }
    }
}

struct WikipediaView_Previews: PreviewProvider {
    static var previews: some View {
        WikipediaView(selected: Binding.constant(2), moreInfo: Binding.constant(nil))
    }
}

struct SafariView: UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }
}
