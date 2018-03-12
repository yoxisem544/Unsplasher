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
  private var rightDisclosureImageView: UIImageView!
  
  public var title: String = "" {
    didSet {
      setTitle(text: title.uppercased())
    }
  }
  
  private var shouldDisclose: Bool = false {
    didSet {
      rotateDisclosureImage()
    }
  }
  
  // MARK: - Init
  public convenience init() {
    let height: CGFloat = DeviceDetector.isiPhoneX ? 88 : 64
    self.init(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width,
                                                        height: height)))
    
    backgroundColor = .white
    applyShadow(shadowRadius: 0.5,
                shadowOpacity: 1,
                shadowColor: UnsplasherColor.gray,
                shadowOffset: CGSize(width: 0, height: 0.5))
    
    configureTitleLabel()
    configureRightDisclosureImageView()
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
      .changeFont(to: .boldSystemFont(ofSize: 17))
      .changeTextColor(to: UnsplasherColor.dark)
      .changeNumberOfLines(to: 1)
      .changeTextAlignment(to: .center)
      .anchor(to: self)
    
    titleLabel.isUserInteractionEnabled = true
    titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UnsplasherNavigationBar.disclouseActionRecieved)))
  }
  
  private func configureRightDisclosureImageView() {
    let height = 7.cgFloat
    let width = height * 2
    rightDisclosureImageView = UIImageView(frame: CGRect(origin: .zero,
                                                         size: CGSize(width: width, height: height)))
    rightDisclosureImageView.contentMode = .scaleAspectFill
    rightDisclosureImageView.image = #imageLiteral(resourceName: "DownDisclosureIcon")
    rightDisclosureImageView.anchor(to: self)
    
    rightDisclosureImageView.isUserInteractionEnabled = true
    rightDisclosureImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UnsplasherNavigationBar.disclouseActionRecieved)))
    
    adjustDisclosureImageView()
  }
  
  private func adjustDisclosureImageView() {
    rightDisclosureImageView
      .move(2, pointsRightFrom: titleLabel)
      .centerY(to: titleLabel)
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
    
    adjustDisclosureImageView()
  }
  
  @objc private func disclouseActionRecieved() {
    shouldDisclose = !shouldDisclose
  }
  
  private func rotateDisclosureImage() {
    let transform = shouldDisclose ? CGAffineTransform(rotationAngle: CGFloat.pi) : CGAffineTransform.identity
    UIView.animate(withDuration: 0.2,
                   delay: 0,
                   options: .curveEaseOut,
                   animations: {
                    self.rightDisclosureImageView.transform = transform
    }, completion: nil)
  }
  
}

