//
//  PhotoDisplayListCell.swift
//  Unsplasher
//
//  Created by David on 2018/3/12.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit

final public class PhotoDisplayListCell: UICollectionViewCell {
  
  @IBOutlet weak var contentImageView: UIImageView!
  @IBOutlet weak var photographerContainerView: UIView!
  @IBOutlet weak var avatorImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var socialMediaLabel: UILabel!
  
  public var photoViewModel: PhotosViewModel? {
    didSet {
      guard let vm = photoViewModel else { return }
      contentImageView.setImage(with: vm.photoURLs.regular)
      nameLabel.text = vm.author
    }
  }
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    
    contentImageView.layer.cornerRadius = 4.0
    contentImageView.contentMode = .scaleAspectFill
    contentImageView.clipsToBounds = true
    
    photographerContainerView.backgroundColor = UIColor.white.withAlpha(0.7)
    
    avatorImageView.contentMode = .scaleAspectFill
    avatorImageView.clipsToBounds = true
    avatorImageView.layer.cornerRadius = 14
    
    avatorImageView.image = SampleImages.getOne()
    
    nameLabel
      .changeFont(to: UIFont.boldSystemFont(ofSize: 12))
      .changeTextColor(to: UnsplasherColor.dark)
  }
  
}
