//
//  SampleImages.swift
//  Unsplasher
//
//  Created by David on 2018/3/9.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit.UIImage

public struct SampleImages {
  
  static func getOne() -> UIImage {
    let imageName = "sample_image\(arc4random_uniform(16) + 1)"
    return UIImage(named: imageName)!
  }
  
}
