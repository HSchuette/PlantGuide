//
//  StoreImagePicker.swift
//  PlantGuide
//
//  Created by (non work) on 08.11.20.
//

import Foundation
import SwiftUI

class storeImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var image: UIImage?
    @Binding var isStoreImagePickerVisible: Bool
    @Binding var plantID: String
    @Binding var imagePath: String
    
    init(image: Binding<UIImage?>, isStoreImagePickerVisible: Binding<Bool>, plantID: Binding<String>, imagePath: Binding<String>) {
        _image = image
        _isStoreImagePickerVisible = isStoreImagePickerVisible
        _plantID = plantID
        _imagePath = imagePath
    }
    
    func storeImagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = uiImage
            isStoreImagePickerVisible = false
        }
        
        do {
            try imagePath = ImageStore.store(image: image!, name: "\(plantID)", filepath: imagePath)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isStoreImagePickerVisible = false
    }
    
}

struct storeImagePicker: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = storeImagePickerCoordinator
    
    @Binding var image: UIImage?
    @Binding var isStoreImagePickerVisible: Bool
    @Binding var plantID: String
    @Binding var imagePath: String
    
    var sourceType: UIImagePickerController.SourceType = .camera
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<storeImagePicker>) {
    }
    
    func makeCoordinator() -> storeImagePicker.Coordinator {
        return storeImagePickerCoordinator(image: $image, isStoreImagePickerVisible: $isStoreImagePickerVisible, plantID: $plantID, imagePath: $imagePath)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<storeImagePicker>) -> UIImagePickerController {
        
        let selector = UIImagePickerController()
        selector.sourceType = sourceType
        selector.allowsEditing = false
        selector.delegate = context.coordinator
        return selector
    }
}
