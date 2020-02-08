//
//  CKAssetExtension.swift
//  mySimpleContinuum
//
//  Created by Uzo on 2/8/20.
//  Copyright © 2020 Uzo Agu. All rights reserved.
//

import UIKit
import CloudKit

protocol CKPhotoAssetAttributable {
    var photo: UIImage? {get set }
    var photoData: Data? { get }
    var photAsset: CKAsset? { get }
}

extension CKPhotoAssetAttributable {
    var photoData: Data? {
        get {
            guard let photo = photo else { return nil }
            
            return photo.jpegData(compressionQuality: 0.5)
        }
    }
    
    var photoAsset: CKAsset? {
        //not having this guard check will break being able to create posts without photos
        guard photoData != nil else { return nil}
        
        let tempDir = NSTemporaryDirectory()
        let tempDirUrl = URL(fileURLWithPath: tempDir)
        let fileURL = tempDirUrl.appendingPathComponent(UUID().uuidString).appendingPathExtension("jpg")
        
        do {
            try photoData?.write(to: fileURL)
        } catch {
            print("Error in \(#line) of \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
        return CKAsset(fileURL: fileURL)
    }
}

extension CKAsset {
    func getImageFromAsset() -> UIImage? {
        guard let unwrappedfileURL = self.fileURL else {
            print("Could not unwrapped fileURL: \(String(describing: self.fileURL)). See Error in function:\(#function) and line: \(#line)")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: unwrappedfileURL)
            return UIImage(data: data)
        } catch {
            print("Could not transforem asset to data")
        }
        return nil
    }
}
