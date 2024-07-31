//
//  ImageStore.swift
//  Weto
//
//  Created by Hanan on 30/12/2020.
//

import UIKit

class ImageStore {

    let cache = NSCache<NSString,UIImage>()
    
    // get local image url
    func imageURL(forKey key: String) -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let documentDirectory =
            documentsDirectories.first!
        
        return documentDirectory.appendingPathComponent(key)
    }
    
    // save image locally
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        
        let url = imageURL(forKey: key)  // Create full URL for image
        
        if let data = image.jpegData(compressionQuality: 0.5) {  // Turn image into JPEG data
            try? data.write(to: url) // Write it to full URL
        }
    }
    
    // return savaed image from disk
    func image(forKey key: String) -> UIImage? {
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }
        
        let url = imageURL(forKey: key)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
    }
    
    // delete saved image from disk
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
        
        let url = imageURL(forKey: key)
        do {
            try FileManager.default.removeItem(at: url)
            
        } catch {
            print("Error removing the image from disk: \(error)") }
    }
    
}
