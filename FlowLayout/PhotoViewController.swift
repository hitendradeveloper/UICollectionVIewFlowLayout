//
//  PhotoViewController.swift
//  FlowLayout
//
//  Created by Hitendra iDev on 05/02/17.
//  Copyright © 2017 Hitendra iDev. All rights reserved.
//

import UIKit
import AVFoundation

class PhotoViewController: UICollectionViewController {
  
  var photos = Photo.allPhotos()
  
  override var preferredStatusBarStyle : UIStatusBarStyle {
    return UIStatusBarStyle.lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    if let patternImage = UIImage(named: "Pattern") {
      view.backgroundColor = UIColor(patternImage: patternImage)
    }
    
    collectionView!.backgroundColor = UIColor.clear
    collectionView!.contentInset = UIEdgeInsets(top: 23, left: 5, bottom: 10, right: 5)
  }
  
}

extension PhotoViewController {
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
    cell.photo = photos[(indexPath as NSIndexPath).item]
    return cell
  }
  
}


