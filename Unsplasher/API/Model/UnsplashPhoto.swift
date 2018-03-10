//
//  UnsplashPhoto.swift
//  Unsplasher
//
//  Created by David on 2018/3/10.
//  Copyright © 2018年 David. All rights reserved.
//

import Foundation

public struct UnsplashPhoto: Decodable, CustomStringConvertible {
  
  public var description: String {
    return """
    UnsplashPhoto 🌇: [
    \tid: \(id)
    \tcreatedAt: \(createdAt)
    \twidth: \(width)
    \theight: \(height)
    \tcolor: \(color)
    \tlikes: \(likes)
    \tlikedByUser: \(likedByUser)
    \tphotoDescription: \(photoDescription)
    \turls: \(urls)
    \tlinks: \(links)
    \tupdatedAt: \(updatedAt)
    \tsponsored: \(sponsored)
    ]
    """
  }
  
  let id, createdAt: String
  let width, height: Int
  let color: String
  let likes: Int
  let likedByUser: Bool
  let photoDescription: String?
//  let currentUserCollections: [String]
  let urls: UnsplashPhotoURLs
  let links: UnsplashPhotoLinks
  let updatedAt: String
  let sponsored: Bool
//  let categories: []
  
  enum CodingKeys: String, CodingKey {
    case id
    case createdAt = "created_at"
    case width, height, color, likes
    case likedByUser = "liked_by_user"
    case photoDescription = "description"
//    case currentUserCollections = "current_user_collections"
    case urls, links
    case updatedAt = "updated_at"
    case sponsored
    case categories
  }
}

extension UnsplashPhoto {
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    id = try container.decode(String.self, forKey: CodingKeys.id)
    createdAt = try container.decode(String.self, forKey: CodingKeys.createdAt)
    width = try container.decode(Int.self, forKey: CodingKeys.width)
    height = try container.decode(Int.self, forKey: CodingKeys.height)
    color = try container.decode(String.self, forKey: CodingKeys.color)
    likes = try container.decode(Int.self, forKey: CodingKeys.likes)
    likedByUser = try container.decode(Bool.self, forKey: CodingKeys.likedByUser)
    photoDescription = try container.decodeIfPresent(String.self, forKey: CodingKeys.photoDescription)
//    currentUserCollections = try container.decode([String].self, forKey: CodingKeys.currentUserCollections)
    urls = try container.decode(UnsplashPhotoURLs.self, forKey: CodingKeys.urls)
    links = try container.decode(UnsplashPhotoLinks.self, forKey: CodingKeys.links)
    updatedAt = try container.decode(String.self, forKey: CodingKeys.updatedAt)
    sponsored = try container.decode(Bool.self, forKey: CodingKeys.sponsored)
  }
  
}

public struct UnsplashPhotoURLs: Codable {
  let raw, full, regular, small, thumb: String
}

public struct UnsplashPhotoLinks: Codable {
  let `self`, html, download, downloadLocation: String

  enum CodingKeys: String, CodingKey {
    case `self`, html, download
    case downloadLocation = "download_location"
  }
}
