//
//  UnsplashUser.swift
//  Unsplasher
//
//  Created by David on 2018/3/10.
//  Copyright © 2018年 David. All rights reserved.
//

import Foundation

public enum FollowedByUser: Decodable {
  case yes, no, unknown
  
  init(followed: Bool?) {
    switch followed {
    case .some(let value):
      self = value ? .yes : .no
    default:
      self = .unknown
    }
  }
  
  enum CodingKeys: String, CodingKey {
    case followedByUser = "followed_by_user"
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let followed = try container.decodeIfPresent(Bool.self, forKey: FollowedByUser.CodingKeys.followedByUser)
    
    self = FollowedByUser(followed: followed)
  }
}

public struct UnsplashUser: Decodable, CustomStringConvertible {
  
  public var description: String {
    return """
    UnsplashUser 🙋🏻‍♀️: [
    \tid: \(id)
    \tusername: \(username)
    \tname: \(name)
    \tfirstName: \(firstName)
    \tlastName: \(lastName)
    \tinstagramUsername: \(instagramUsername)
    \ttwitterUsername: \(twitterUsername)
    \tportfolioURL: \(portfolioURL)
    \ttotalLikes: \(totalLikes)
    \ttotalPhotos: \(totalPhotos)
    \ttotalCollections: \(totalCollections)
    \tprofileImage: \(profileImage)
    \tlinks: \(links)
    \tupdatedAt: \(updatedAt)
    \tfollowedByUser: \(followedByUser)
    \tbio: \(bio)
    \tlocation: \(location)
    ]
    """
  }
  
  let id, username: String
  let name, firstName, lastName, instagramUsername, twitterUsername, portfolioURL: String?
  let totalLikes, totalPhotos, totalCollections: Int
  let profileImage: UserProfileImage
  let links: UnsplashUserLinks
  let updatedAt: String
  let followedByUser: FollowedByUser
  let bio: String?
  let location: String?
  
  enum CodingKeys: String, CodingKey {
    case id, username, name
    case firstName = "first_name"
    case lastName = "last_name"
    case instagramUsername = "instagram_username"
    case twitterUsername = "twitter_username"
    case portfolioURL = "portfolio_url"
    case totalLikes = "total_likes"
    case totalPhotos = "total_photos"
    case totalCollections = "total_collections"
    case profileImage = "profile_image"
    case links
    case updatedAt = "updated_at"
    case followedByUser = "followed_by_user"
    case bio = "bio"
    case location
  }
  
}

// MARK: Convenience initializers

extension UnsplashUser {
  
  public init(data: Data) throws {
    self = try JSONDecoder().decode(UnsplashUser.self, from: data)
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    id = try container.decode(String.self, forKey: CodingKeys.id)
    username = try container.decode(String.self, forKey: CodingKeys.username)
    name = try container.decodeIfPresent(String.self, forKey: CodingKeys.name)
    firstName = try container.decodeIfPresent(String.self, forKey: CodingKeys.firstName)
    lastName = try container.decodeIfPresent(String.self, forKey: CodingKeys.lastName)
    instagramUsername = try container.decodeIfPresent(String.self, forKey: CodingKeys.instagramUsername)
    twitterUsername = try container.decodeIfPresent(String.self, forKey: CodingKeys.twitterUsername)
    portfolioURL = try container.decodeIfPresent(String.self, forKey: CodingKeys.portfolioURL)
    totalLikes = try container.decode(Int.self, forKey: CodingKeys.totalLikes)
    totalPhotos = try container.decode(Int.self, forKey: CodingKeys.totalPhotos)
    totalCollections = try container.decode(Int.self, forKey: CodingKeys.totalCollections)
    profileImage = try container.decode(UserProfileImage.self, forKey: CodingKeys.profileImage)
    links = try container.decode(UnsplashUserLinks.self, forKey: CodingKeys.links)
    updatedAt = try container.decode(String.self, forKey: CodingKeys.updatedAt)
    let followedByUser = try container.decodeIfPresent(Bool.self, forKey: CodingKeys.followedByUser)
    self.followedByUser = FollowedByUser(followed: followedByUser)
    bio = try container.decodeIfPresent(String.self, forKey: CodingKeys.bio)
    location = try container.decodeIfPresent(String.self, forKey: CodingKeys.location)
  }

}

public struct UnsplashUserLinks: Codable {
  let `self`, likes, followers, html, following, photos, portfolio: String?
  
  enum CodingKeys: String, CodingKey {
    case `self`, likes, followers, html, following, photos, portfolio
  }
}



