//
//  PhotoDisplayView.swift
//  Unsplasher
//
//  Created by David on 2018/3/9.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit
import CHTCollectionViewWaterfallLayout

public enum PhotoDisplayStyle {
  case grid, list
}

final public class PhotoDisplayView: UIView {
  
  private var gridFlowLayout: CHTCollectionViewWaterfallLayout!
  private var listFlowLayout: CHTCollectionViewWaterfallLayout!
  private var displayingCollectionView: UICollectionView!
  
  public var photos: [PhotosViewModel] = [] {
    didSet {
      displayingCollectionView.reloadData()
    }
  }
  
  public var style: PhotoDisplayStyle = .grid {
    didSet {
      changeViewingMode(style)
    }
  }
  private let lineSpacing: CGFloat = 8
  private let interitemSpacing: CGFloat = 8
  private var itemsPerRow: Int {
    switch style {
    case .grid:
      return 2
    case .list:
      return 1
    }
  }
  
  private var itemSize: CGSize {
    get {
      switch style {
      case .grid:
        let width = (bounds.width - (3 * interitemSpacing)) / itemsPerRow.cgFloat
        return CGSize(width: width, height: width)
      case .list:
        let width = (bounds.width - (2 * interitemSpacing))
        return CGSize(width: width, height: width)
      }
    }
  }
  
  // MARK: - Init
  public convenience init(height: CGFloat, width: CGFloat) {
    self.init(frame: CGRect(origin: .zero, size: CGSize(width: width, height: height)))
    
    configureDisplayingCollectionView()
  }
  
  private override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureDisplayingCollectionView() {
    gridFlowLayout = CHTCollectionViewWaterfallLayout()
    gridFlowLayout.columnCount = 2
    gridFlowLayout.minimumColumnSpacing = lineSpacing
    gridFlowLayout.minimumInteritemSpacing = interitemSpacing
    gridFlowLayout.sectionInset = UIEdgeInsets(top: interitemSpacing,
                                               left: interitemSpacing,
                                               bottom: interitemSpacing,
                                               right: interitemSpacing)
    
    listFlowLayout = CHTCollectionViewWaterfallLayout()
    listFlowLayout.columnCount = 1
    listFlowLayout.minimumColumnSpacing = lineSpacing
    listFlowLayout.minimumInteritemSpacing = interitemSpacing
    listFlowLayout.sectionInset = UIEdgeInsets(top: interitemSpacing,
                                               left: interitemSpacing,
                                               bottom: interitemSpacing,
                                               right: interitemSpacing)
    
    displayingCollectionView = UICollectionView(frame: bounds,
                                                collectionViewLayout: gridFlowLayout)
    
    displayingCollectionView.backgroundColor = .white
    displayingCollectionView.anchor(to: self)
    
    displayingCollectionView.register(cellTypes: [PhotoDisplayGridCell.self])
    
    displayingCollectionView.dataSource = self
    displayingCollectionView.delegate = self
  }
  
  private func changeViewingMode(_ mode: PhotoDisplayStyle) {
    switch mode {
    case .grid:
      displayingCollectionView.setCollectionViewLayout(gridFlowLayout, animated: true)
    case .list:
      if displayingCollectionView.contentOffset.y <= 50 {
        Queue.delayInMainQueueFor(0.05, block: {
          self.displayingCollectionView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
        })
      }
      displayingCollectionView.setCollectionViewLayout(listFlowLayout, animated: true)
    }
  }
  
}

extension PhotoDisplayView : UICollectionViewDataSource {
  
  public func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(with: PhotoDisplayGridCell.self, for: indexPath)
    cell.photoImageView.setImage(with: photos[indexPath.row].photoURLs.small)
    return cell
  }
  
}

extension PhotoDisplayView : CHTCollectionViewDelegateWaterfallLayout {
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
    let photoSize = photos[indexPath.row].photoSize
    let size = CGSize(width: itemSize.width,
                      height: photoSize.height * itemSize.width / photoSize.width)
    return size
  }
  
}
