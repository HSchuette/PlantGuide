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
    @State var urlString: URL = URL(string: "https://www.apple.com")!
    
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
            }
            .onAppear() {
                print(urlString)
                self.urlString = URL(string: plantData[selected!].wikipediaLink)!
            }
            .onTapGesture {
                print(urlString)
                self.urlString = URL(string: plantData[selected!].wikipediaLink)!
                            
                    self.showSafari = true

                print(urlString)
            }
            .sheet(isPresented: $showSafari) {
                SafariView(url: URL(string: plantData[selected!].wikipediaLink)!)
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
