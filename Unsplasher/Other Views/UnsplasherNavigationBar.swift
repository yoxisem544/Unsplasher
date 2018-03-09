//
//  UnsplasherNavigationBar.swift
//  Unsplasher
//
//  Created by David on 2018/3/9.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit

final public class UnsplasherNavigationBar: UIView {
  
  private var titleLabel: UILabel!
  
  public var title: String = "" {
    didSet {
      setTitle(text: title)
    }
  }
  
  // MARK: - Init
  public convenience init() {
    let height: CGFloat = DeviceDetector.isiPhoneX ? 88 : 64
    self.init(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width,
                                                        height: height)))
    
    backgroundColor = .white
    applyShadow(shadowRadius: 0.1,
                shadowOpacity: 1,
                shadowColor: UnsplasherColor.gray,
                shadowOffset: CGSize(width: 0, height: 1))
    
    configureTitleLabel()
    
  }
  
  private override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureTitleLabel() {
    titleLabel = UILabel()
    titleLabel
      .changeFontSize(to: 17)
      .changeTextColor(to: .black)
      .changeNumberOfLines(to: 1)
      .changeTextAlignment(to: .center)
      .anchor(to: self)
  }
  
  private var barCenterY: CGFloat {
    get {
      if DeviceDetector.isiPhoneX {
        // status bar height is now 44
        // content part is 44
        return 44 + 44 / 2
      } else {
        return 20 + 44 / 2
      }
    }
  }
  
  private func setTitle(text: String) {
    titleLabel.text = text
    titleLabel.sizeToFit()
    titleLabel.centerX(inside: self)
    titleLabel.center.y = barCenterY
  }
  
}

