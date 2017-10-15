//
//  FavoriteCatImageInfo.swift
//  GiniCats
//
//  Created by siwook on 2017. 10. 15..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - FavoriteCatImageInfo
struct FavoriteCatImageInfo {

  // MARK : - Property List
  var url: String
  var imageId: String
  var userId: String
  var createdAt: String

  // MARK : - Initialization
  init(url: String?, imageId: String?, userId: String?, createdAt: String?) throws {
    guard let url = url else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.URLMissing)
    }
    guard let imageId = imageId else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.ImageIdMissing)
    }
    guard let userId = userId else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.UserIdMissing)
    }
    guard let createdAt = createdAt else {
      throw SerializaionError.missing(Constants.SerializaionErrorDesc.CreatedTimeMissing)
    }
    self.url        = url
    self.imageId    = imageId
    self.userId     = userId
    self.createdAt  = createdAt
  }
}
