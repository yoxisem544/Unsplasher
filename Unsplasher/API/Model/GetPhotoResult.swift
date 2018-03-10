//
//  GetPhotoResult.swift
//  Unsplasher
//
//  Created by David on 2018/3/10.
//  Copyright © 2018年 David. All rights reserved.
//

import Foundation

public struct GetPhotoResult: Decodable {
  
  let user: UnsplashUser
  let photo: UnsplashPhoto
  
  enum CodingKeys: String, CodingKey {
    case user
  }
  
}

extension GetPhotoResult {
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let userDecoder = try container.superDecoder(forKey: GetPhotoResult.CodingKeys.user)
    
    user = try UnsplashUser(from: userDecoder)
    photo = try UnsplashPhoto(from: decoder)
  }
  
}
