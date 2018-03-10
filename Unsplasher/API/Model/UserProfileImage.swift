//
//  UserProfileImage.swift
//  Unsplasher
//
//  Created by David on 2018/3/10.
//  Copyright © 2018年 David. All rights reserved.
//

import Foundation

public struct UserProfileImage: Codable, CustomStringConvertible {
  
  public var description: String {
    return """
    \tUserProfileImage 🍁: [
    \t\tsmall: \(small)
    \t\tmedium: \(medium)
    \t\tlarge: \(large)
    \t]
    """
  }
  
  let small, medium, large: String?
  
  enum CodingKeys: String, CodingKey {
    case small, medium, large
  }
}

extension UserProfileImage {
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: UserProfileImage.CodingKeys.self)
    
    small = try container.decodeIfPresent(String.self, forKey: CodingKeys.small)
    medium = try container.decodeIfPresent(String.self, forKey: CodingKeys.medium)
    large = try container.decodeIfPresent(String.self, forKey: CodingKeys.large)
  }
  
}
