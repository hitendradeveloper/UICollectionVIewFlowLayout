//
//  PhotoCell.swift
//  FlowLayout
//
//  Created by Hitendra iDev on 05/02/17.
//  Copyright © 2017 Hitendra iDev. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
  
  @IBOutlet fileprivate weak var imageView: UIImageView!
  @IBOutlet fileprivate weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!

  
  var photo: Photo? {
    didSet {
      if let photo = photo {
        imageView.image = photo.image
      }
    }
  }
  
  override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    super.apply(layoutAttributes)
    if let attributes = layoutAttributes as? MockupLayoutAttributes {
      imageViewHeightLayoutConstraint.constant = attributes.photoHeight
    }
  }
  
}
