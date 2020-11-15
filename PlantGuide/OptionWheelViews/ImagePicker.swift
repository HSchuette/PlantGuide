////
////  ImagePicker.swift
////  PlantRoom
////
////  Created by (non work) on 10.10.20.
////
//
//import Foundation
//import SwiftUI
//
//class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//    
//    @Binding var image: UIImage?
//    @Binding var isImagePickerVisible: Bool
//    @Binding var showClassification: Bool
//    
//    init(image: Binding<UIImage?>, isImagePickerVisible: Binding<Bool>, showClassification: Binding<Bool>) {
//        _image = image
//        _isImagePickerVisible = isImagePickerVisible
//        _showClassification = showClassification
//    }
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        
//        if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            image = uiImage
//            isImagePickerVisible = false
//            
//            // wait a moment for better animation
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
//                self.showClassification.toggle()
//            }
//        }
//    }
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        isImagePickerVisible = false
//    }
//    
//}
//
//struct ImagePicker: UIViewControllerRepresentable {
//    
//    typealias UIViewControllerType = UIImagePickerController
//    typealias Coordinator = ImagePickerCoordinator
//    
//    @Binding var image: UIImage?
//    @Binding var isImagePickerVisible: Bool
//    @Binding var showClassification: Bool
//    
//    var sourceType: UIImagePickerController.SourceType = .camera
//    
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
//    }
//    
//    func makeCoordinator() -> ImagePicker.Coordinator {
//        return ImagePickerCoordinator(image: $image, isImagePickerVisible: $isImagePickerVisible, showClassification: $showClassification)
//    }
//    
//    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
//        
//        let selector = UIImagePickerController()
//        selector.sourceType = sourceType
//        selector.allowsEditing = false
//        selector.delegate = context.coordinator
//        return selector
//    }
//}
