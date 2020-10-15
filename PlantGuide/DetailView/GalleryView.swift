//
//  GalleryView.swift
//  PlantRoom
//
//  Created by (non work) on 10.10.20.
//

import SwiftUI

struct GalleryView: View {
    
    @Binding var selected: Int?
    @Binding var moreInfo: String?
    
    var green = Color(red: 112/256, green: 191/256, blue: 92/256)
    
    func pictureAsset(picture: String?) -> some View {
        return ZStack {
            // check if the picture name exists
            if (UIImage(named: picture!) == nil) {
            } else {
                ZStack {
                    Image(picture!)
                        .resizable()
                        .cornerRadius(25)
                        .frame(width: 125, height: 125)
                        .scaledToFill()
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
                ScrollView(.horizontal, showsIndicators: true) {
                     HStack {
                        ForEach(pictureData, id: \.id) { picture in
                            self.pictureAsset(picture: String(plantData[self.selected!].imageName) + picture.name)
                    }
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
            GalleryView(selected: Binding.constant(1), moreInfo: Binding.constant(nil))
            GalleryView(selected: Binding.constant(1), moreInfo: Binding.constant("moreGallery"))
        }
    }
}
