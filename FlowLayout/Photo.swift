//
//  Photo.swift
//  FlowLayout
//
//  Created by Hitendra iDev on 05/02/17.
//  Copyright © 2017 Hitendra iDev. All rights reserved.
//

import UIKit

class Photo {
  
  class func allPhotos() -> [Photo] {
    var photos = [Photo]()
    if let URL = Bundle.main.url(forResource: "Photos", withExtension: "plist") {
      if let photosFromPlist = NSArray(contentsOf: URL) {
        for dictionary in photosFromPlist {
          let photo = Photo(dictionary: dictionary as! Dictionary<String,String>)
          photos.append(photo)
        }
      }
    }
    return photos + photos + photos;
  }

  var image: UIImage
  
  init(image: UIImage) {
    self.image = image
  }
  
  convenience init(dictionary: Dictionary<String,String>) {
    let photo = dictionary["Photo"]
    let image = UIImage(named: photo!)?.decompressedImage
    self.init(image: image!)
  }  
}
