//
//  UnsplashOAuthData.swift
//  Unsplasher
//
//  Created by David on 2018/3/9.
//  Copyright © 2018年 David. All rights reserved.
//

import Foundation

public struct UnsplashOAuthData: Codable {
  let accessToken, tokenType, scope: String
  let createdAt: Int
  
  enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case tokenType = "token_type"
    case scope
    case createdAt = "created_at"
  }
}

// MARK: Convenience initializers

extension UnsplashOAuthData {
  init(data: Data) throws {
    self = try JSONDecoder().decode(UnsplashOAuthData.self, from: data)
  }
  
  init(_ json: String, using encoding: String.Encoding = .utf8) throws {
    guard let data = json.data(using: encoding) else {
      throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
    }
    try self.init(data: data)
  }
  
  init(fromURL url: URL) throws {
    try self.init(data: try Data(contentsOf: url))
  }
  
  func jsonData() throws -> Data {
    return try JSONEncoder().encode(self)
  }
  
  func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
    return String(data: try self.jsonData(), encoding: encoding)
  }
}
