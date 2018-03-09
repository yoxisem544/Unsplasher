//
//  UnsplashAPI.swift
//  Unsplasher
//
//  Created by David on 2018/3/9.
//  Copyright © 2018年 David. All rights reserved.
//

import NetworkRequestKit

public extension NetworkRequest {
  
  var baseURL: String { return "https://api.unsplash.com/" }
  var accessToken: String { return "SOMETOKEN" }
  var headers: [String : String] { return ["Accept-Version": "v1"] }

}

public struct UnsplashAPI {
  
  
  
}

/// To write data on behalf of a user or to access their private data,
/// you must request additional permission scopes from them.
///
/// - `public`: Default. Read public data.
/// - readUser: Access user’s private data.
/// - writeUser: Update the user’s profile.
/// - readPhotos: Read private data from the user’s photos.
/// - writePhotos: Update photos on the user’s behalf.
/// - writeLikes: Like or unlike a photo on the user’s behalf.
/// - writeFollowers: Follow or unfollow a user on the user’s behalf.
/// - readCollections: View a user’s private collections.
/// - writeCollections: Create and update a user’s collections.
public enum UnsplashAPIPermissionScope: String {
  case `public` = "public"
  case readUser = "read_user"
  case writeUser = "write_user"
  case readPhotos = "read_photos"
  case writePhotos = "write_photos"
  case writeLikes = "write_likes"
  case writeFollowers = "write_followers"
  case readCollections = "read_collections"
  case writeCollections = "write_collections"
  
  public static func join(scopes: [UnsplashAPIPermissionScope]) -> String {
    return scopes
      .map({ $0.rawValue })
      .joined(separator: "+")
  }
  
  public static var allScopes: String {
    return join(scopes: [.public, .readUser, .writeUser, .readPhotos, .writePhotos, .writeLikes, .writeFollowers, .readCollections, .writeCollections])
  }
}
