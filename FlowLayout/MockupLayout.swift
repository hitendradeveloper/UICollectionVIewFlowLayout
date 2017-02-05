//
//  MockupLayout.swift
//  FlowLayout
//
//  Created by Hitendra iDev on 05/02/17.
//  Copyright © 2017 Hitendra iDev. All rights reserved.
//

import UIKit



class MockupLayoutAttributes: UICollectionViewLayoutAttributes {
  
  // 1
  var photoHeight: CGFloat = 0.0
  
  // 2
  override func copy(with zone: NSZone? = nil) -> Any {
    let copy = super.copy(with: zone) as! MockupLayoutAttributes
    copy.photoHeight = photoHeight
    return copy
  }
  
  // 3
  override func isEqual(_ object: Any?) -> Bool {
    if let attributes = object as? MockupLayoutAttributes {
      if( attributes.photoHeight == photoHeight  ) {
        return super.isEqual(object)
      }
    }
    return false
  }
}

class MockupLayout: UICollectionViewLayout {
  
  // 2
  var numberOfColumns = 3
  var cellPadding: CGFloat = 2.0
  
  // 3
  private var cache = [MockupLayoutAttributes]()
  
  // 4
  private var contentHeight: CGFloat  = 0.0
  private var contentWidth: CGFloat {
    let insets = collectionView!.contentInset
    return collectionView!.bounds.size.width - (insets.left + insets.right)
  }
  var cellWidth : CGFloat {
    return self.contentWidth / CGFloat(numberOfColumns)
  }
  var cellHeight : CGFloat {
    return self.cellWidth * 0.85;
  }

  
  var totalItems : Int {
    return collectionView!.numberOfItems(inSection: 0)
  }
  
  var totalLayoutItem : Int = 9
  
  var fixColumns : [Int] {
    return [0,1,2,
            0,1,
            0,1,2,
            0
    ]
  }
  
  var fixItemWidths : [CGFloat] {
    let cellWidth = self.contentWidth / CGFloat(numberOfColumns)
    return [cellWidth,
            cellWidth,
            cellWidth,
            cellWidth,
            cellWidth,
            cellWidth,
            cellWidth,
            cellWidth,
            self.contentWidth
    ]
  }
  
  var fixItemHeights : [CGFloat] {
    let cellHeight = self.cellHeight
    return [cellHeight,
                               cellHeight,
                               cellPadding + cellHeight*2 + cellPadding,
                               cellHeight,
                               cellHeight,
                               cellHeight,
                               cellHeight,
                               cellHeight,
                               cellHeight*2
    ]
  }
  
  var fixItemXOffsets : [CGFloat] {
    
    var arrXOffset = [CGFloat]()
    for column in 0 ..< numberOfColumns {//3
      arrXOffset.append(CGFloat(column) * self.fixItemWidths[column] )
    }
    for column in 0 ..< numberOfColumns-1 {//2
      arrXOffset.append(CGFloat(column) * self.fixItemWidths[column] )
    }
    for column in 0 ..< numberOfColumns {//3
      arrXOffset.append(CGFloat(column) * self.fixItemWidths[column] )
    }
    for column in 0 ..< 1 {//1
      arrXOffset.append(CGFloat(column) * self.fixItemWidths[column] )
    }
    return arrXOffset;
  }
  
  func fixItemYOffsets(lastOffsets : CGFloat = 0.0) -> [CGFloat] {
    var arrYOffset = [CGFloat]()
    
    var yOffset : CGFloat = lastOffsets;
    for _ in 0 ..< numberOfColumns {//3
      arrYOffset.append(yOffset)
    }
    
    yOffset = arrYOffset[arrYOffset.count-1] + self.cellHeight + cellPadding * 2
    for _ in 0 ..< numberOfColumns-1 {//2
      arrYOffset.append(yOffset)
    }
    
    yOffset = arrYOffset[arrYOffset.count-1] + self.cellHeight + cellPadding * 2
    for _ in 0 ..< numberOfColumns {//3
      arrYOffset.append(yOffset)
    }
    
    yOffset = arrYOffset[arrYOffset.count-1] + self.cellHeight + cellPadding * 2
    for _ in 0 ..< 1 {//1
      arrYOffset.append(yOffset)
    }
    
    return arrYOffset;
  }
  
  override open class var layoutAttributesClass: Swift.AnyClass {
    return MockupLayoutAttributes.self
  }
  
  override func prepare() {

    if cache.isEmpty {
      
      //prepate required arrays
      var arrColumns : [Int] = []
      
      var arrItemWidths : [CGFloat] = []
      var arrItemHeights : [CGFloat] = []
      
      var arrXOffset : [CGFloat] = []
      var arrYOffset : [CGFloat] = []
      
      var lastOffset : CGFloat = 0.0;

      
      for i in 0 ..< self.totalItems {
        arrColumns.append(self.fixColumns[i%self.totalLayoutItem]);
        arrItemWidths.append(self.fixItemWidths[i%self.totalLayoutItem]);
        arrItemHeights.append(self.fixItemHeights[i%self.totalLayoutItem]);
        arrXOffset.append(self.fixItemXOffsets[i%self.totalLayoutItem]);
        
        if(i >= self.totalLayoutItem && i % self.totalLayoutItem == 0){
          lastOffset = arrYOffset[arrYOffset.count-1] + cellHeight + cellHeight + cellPadding + cellPadding
        }
        arrYOffset.append(self.fixItemYOffsets(lastOffsets: lastOffset)[i%self.totalLayoutItem]);
      }
      
      
      
      // calculate size if items
      for item in 0 ..< self.totalItems {
        
        let indexPath = IndexPath(item: item, section: 0)
        let columnWidth = arrItemWidths[item]
        

        let photoHeight : CGFloat = arrItemHeights[item];
        
        let height = cellPadding +  photoHeight + cellPadding
        
        let frame = CGRect(x: arrXOffset[item], y: arrYOffset[item], width: columnWidth, height: height)
        
        let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
        
        // 5
        
        let attributes = MockupLayoutAttributes(forCellWith: indexPath)
        attributes.photoHeight = photoHeight
        attributes.frame = insetFrame
        cache.append(attributes)
        
        // 6
        contentHeight = max(contentHeight, frame.maxY)
      }
    }
  }
  
  override var collectionViewContentSize: CGSize {
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    
    var layoutAttributes = [UICollectionViewLayoutAttributes]()
    
    for attributes in cache {
      if attributes.frame.intersects(rect) {
        layoutAttributes.append(attributes)
      }
    }
    return layoutAttributes
  }
}
