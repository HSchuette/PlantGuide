//
//  ImageStore.swift
//  PlantGuide
//
//  Created by (non work) on 08.11.20.
//

import Foundation
import SwiftUI
import UIKit

struct ImageStore {
    
    // remove an image
    static func delete(imageNamed name: String) {
        guard let imagePath = ImageStore.path(for: name) else {
            return
        }
        
        try? FileManager.default.removeItem(at: imagePath)
    }
    
    // request the image
    static func retrieve(imageNamed name: String) -> UIImage? {
        guard let imagePath = ImageStore.path(for: name) else {
            return nil
        }
        
        return UIImage(contentsOfFile: imagePath.path)
    }
    
    // store an image
    static func store(image: UIImage, name: String, filepath: String) throws -> String {
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw NSError(domain: "com.thecodedself.imagestore", code: 0, userInfo: [NSLocalizedDescriptionKey: "The image could not be created"])
        }
        
        var counter = 0
        var newFileName = name
        
        while FileManager.default.fileExists(atPath: ImageStore.path(for: newFileName, fileExtension: "jpg")!.path) {
            counter += 1
            newFileName =  "\(name)_\(counter)"
        }
        
        guard let finalImagePath = ImageStore.path(for: newFileName) else {
            throw NSError(domain: "com.thecodedself.imagestore", code: 0, userInfo: [NSLocalizedDescriptionKey: "The image path could not be retrieved"])
        }
    
        try imageData.write(to: finalImagePath)
        
        return finalImagePath.absoluteString
    }
    
    private static func path(for imageName: String, fileExtension: String = "jpg") -> URL? {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return directory?.appendingPathComponent("\(imageName).\(fileExtension)")
    }
}
