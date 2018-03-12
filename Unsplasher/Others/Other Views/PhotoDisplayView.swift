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
  
  private var itemWidth: CGFloat {
    get {
      switch style {
      case .grid:
        let width = (bounds.width - (3 * interitemSpacing)) / itemsPerRow.cgFloat
        return width
      case .list:
        let width = (bounds.width - (2 * interitemSpacing))
        return width
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
    
    displayingCollectionView.register(cellTypes: [PhotoDisplayGridCell.self, PhotoDisplayListCell.self])
    
    displayingCollectionView.dataSource = self
    displayingCollectionView.delegate = self
  }
  
  private func changeViewingMode(_ mode: PhotoDisplayStyle) {
    displayingCollectionView.reloadData()
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
    switch style {
    case .grid:
      let cell = collectionView.dequeueReusableCell(with: PhotoDisplayGridCell.self, for: indexPath)
      cell.photoViewModel = photos[indexPath.row]
      return cell
    case .list:
      let cell = collectionView.dequeueReusableCell(with: PhotoDisplayListCell.self, for: indexPath)
      cell.photoViewModel = photos[indexPath.row]
      return cell
    }
  }
  
}

extension PhotoDisplayView : CHTCollectionViewDelegateWaterfallLayout {
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
    switch style {
    case .grid:
      let photoSize = photos[indexPath.row].photoSize
      let size = CGSize(width: itemWidth,
                        height: photoSize.height * itemWidth / photoSize.width)
      return size
      
    case .list:
      let photoSize = photos[indexPath.row].photoSize
      let size = CGSize(width: itemWidth,
                        height: photoSize.height * itemWidth / photoSize.width + 44.cgFloat)
      return size
    }
  }
  
}
