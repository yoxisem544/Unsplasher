//
//  PhotoDisplayGridCell.swift
//  Unsplasher
//
//  Created by David on 2018/3/9.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit

final public class PhotoDisplayGridCell: UICollectionViewCell {
  
  @IBOutlet weak var photoImageView: UIImageView!
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    
    photoImageView.contentMode = .scaleAspectFill
    photoImageView.layer.cornerRadius = 4.0
    photoImageView.clipsToBounds = true
    
  }
  
  public override func prepareForReuse() {
    super.prepareForReuse()
  }
  
}
