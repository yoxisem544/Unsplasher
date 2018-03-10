//
//  SearchUserResultsWithTotalPages.swift
//  Unsplasher
//
//  Created by David on 2018/3/10.
//  Copyright © 2018年 David. All rights reserved.
//

import Foundation

public struct SearchUserResultsWithTotalPages: Decodable, CustomStringConvertible {
  
  public var description: String {
    return """
    === Result of searching users ===
    total: \(total),
    total pages: \(totalPages)
    results: \(results)
    === End of search users result ===
    """
  }
  
  let total, totalPages: Int
  let results: [SearchUserResult]
  
  enum CodingKeys: String, CodingKey {
    case total
    case totalPages = "total_pages"
    case results
  }
  
}
