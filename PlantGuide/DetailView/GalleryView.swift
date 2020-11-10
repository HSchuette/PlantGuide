//
//  GalleryView.swift
//  PlantRoom
//
//  Created by (non work) on 10.10.20.
//

import SwiftUI

struct GalleryView: View {
    
    @EnvironmentObject var selectedPlant: SelectedPlant
    
    @Binding var moreInfo: String?
    
    let green = Color(red: 112/256, green: 191/256, blue: 92/256)
    
    // Some pictures have been provided by terra botanika
    private let terraBot = [0, 9, 10, 11, 15]
    
    func pictureAsset(picture: String?) -> some View {
        return ZStack {
            // check if the picture name exists
            if (UIImage(named: picture!) == nil) {
            } else {
                ZStack {
                    Image(picture!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 125, height: 125)
                        .cornerRadius(25)
                        .shadow(color: Color(UIColor.black).opacity( 0.25), radius: 2, x: 2, y: 4)
                    
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(style: StrokeStyle(lineWidth: 5))
                        .foregroundColor(Color(.systemBackground).opacity(0.2))
                        .blur(radius: 1)
                        .frame(width: 125, height: 125)
                }
                .padding(.horizontal, 5)
                .padding(.vertical, 10)
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                CircleIcon(color: green, image: "photo.fill")
                
                Text("Gallery")
                    .bold()
                    .padding()
                
                Spacer()
                
            }
            if self.moreInfo == "moreGallery" {
                VStack {
                    ScrollView(.horizontal, showsIndicators: true) {
                         HStack {
                            ForEach(pictureData, id: \.id) { picture in
                                self.pictureAsset(picture: String(selectedPlant.imageName) + picture.name)
                            }
                         }
                    }
                    // if the plant pictures have been provided by
                    // terra botanika, display a link to the instagram
                    if terraBot.contains(selectedPlant.id) {
                        InstagramHandleView()
                    }
            }
            
            // pictureAsset(picture: pictureData[self.selected!].name)
            
            
            }
        }
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GalleryView(moreInfo: Binding.constant(nil))
                .environmentObject(SelectedPlant())
            GalleryView(moreInfo: Binding.constant("moreGallery"))
                .environmentObject(SelectedPlant())
        }
    }
}
