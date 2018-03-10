//
//  SearchUserResult.swift
//  Unsplasher
//
//  Created by David on 2018/3/10.
//  Copyright © 2018年 David. All rights reserved.
//

import Foundation

public struct SearchUserResult: Decodable {
  
  let user: UnsplashUser
  let photos: [UnsplashPhoto]
  
  enum CodingKeys: String, CodingKey {
    case photos
  }

}

extension SearchUserResult {
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    photos = try container.decode([UnsplashPhoto].self, forKey: CodingKeys.photos)
    
    user = try UnsplashUser(from: decoder)
  }
  
}


