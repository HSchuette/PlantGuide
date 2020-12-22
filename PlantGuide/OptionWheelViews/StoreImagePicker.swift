//
//  StoreImagePicker.swift
//  PlantGuide
//
//  Created by (non work) on 08.11.20.
//

import Foundation
import SwiftUI

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var image: UIImage?
    @Binding var isStoreImagePickerVisible: Bool
    @Binding var plantID: String
    @Binding var imagePath: String
    @Binding var isRecursive: Bool
    
    init(image: Binding<UIImage?>, isStoreImagePickerVisible: Binding<Bool>, plantID: Binding<String>, imagePath: Binding<String>, isRecursive: Binding<Bool>) {
        _image = image
        _isStoreImagePickerVisible = isStoreImagePickerVisible
        _plantID = plantID
        _imagePath = imagePath
        _isRecursive = isRecursive
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = uiImage
            isStoreImagePickerVisible = false
        }
        
        do {
            try imagePath = ImageStore.store(image: image!, name: "\(plantID)", filepath: imagePath, recursive: isRecursive)
            
            print(imagePath)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isStoreImagePickerVisible = false
    }
    
}

struct ImagePicker: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = ImagePickerCoordinator
    
    @Binding var image: UIImage?
    @Binding var isStoreImagePickerVisible: Bool
    @Binding var plantID: String
    @Binding var imagePath: String
    @Binding var isRecursive: Bool
    
    var sourceType: UIImagePickerController.SourceType = .camera
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePickerCoordinator(image: $image, isStoreImagePickerVisible: $isStoreImagePickerVisible, plantID: $plantID, imagePath: $imagePath, isRecursive: $isRecursive)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let selector = UIImagePickerController()
        selector.sourceType = sourceType
        selector.allowsEditing = false
        selector.delegate = context.coordinator
        return selector
    }
}
