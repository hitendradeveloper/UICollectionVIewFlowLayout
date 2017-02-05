//
//  UIImage+Decompression.swift
//  FlowLayout
//
//  Created by Hitendra iDev on 05/02/17.
//  Copyright © 2017 Hitendra iDev. All rights reserved.
//

import UIKit

extension UIImage {
  
  var decompressedImage: UIImage {
    UIGraphicsBeginImageContextWithOptions(size, true, 0)
    draw(at: CGPoint.zero)
    let decompressedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return decompressedImage!
  }
  
}
