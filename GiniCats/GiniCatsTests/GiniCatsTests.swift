//
//  GiniCatsTests.swift
//  GiniCatsTests
//
//  Created by siwook on 2017. 10. 16..
//  Copyright © 2017년 siwook. All rights reserved.
//

import XCTest
@testable import GiniCats

class GiniCatsTests: XCTestCase {

  let apiKey = "MTkxNzY4"
  var sessionUnderTest: URLSession!
  var restClient: RestClient!
  var favoringImageIsFavorite: Bool!
  var favoringImageId: String!

  override func setUp() {
    super.setUp()

    sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    restClient = RestClient()
    favoringImageIsFavorite = true
    favoringImageId = "ba1"
  }

  override func tearDown() {
    super.tearDown()
    sessionUnderTest = nil
    restClient = nil
    favoringImageIsFavorite = nil
    favoringImageId = nil
  }

  func testValidCallToCatListGetHTTPStatusCode200() {

    let promise = expectation(description: "Receive cat list xml data")

    restClient.requestCatImageInfoList { (_, error) in
      if let error = error {
        XCTFail("\(error.localizedDescription)")
      } else {
        promise.fulfill()
      }
    }
    waitForExpectations(timeout: 5, handler: nil)
  }

  func testValidCallToFavoriteCatListGetHTTPStatusCode200() {

    let promise = expectation(description: "Receive favorite cat list xml data")

    restClient.requestFavoriteCatImageInfoList { (_, error) in
      if let error = error {
        XCTFail("\(error.localizedDescription)")
      } else {
        promise.fulfill()
      }
    }
    waitForExpectations(timeout: 5, handler: nil)
  }

  func testValidCallToMarkFavoriteCatGetResponse() {

    let promise = expectation(description: "Mark favorite cat")

    print(favoringImageIsFavorite)
    restClient.requestFavoringImageBasedOn(isFavorite: favoringImageIsFavorite, imageId: favoringImageId) { response in
      if let response = response {
        XCTFail("\(response)")
      } else {
        promise.fulfill()
        self.favoringImageIsFavorite = !self.favoringImageIsFavorite
      }
    }
    waitForExpectations(timeout: 5, handler: nil)
  }

  func testValidCallToUndoMarkFavoriteCatGetHTTPStatusCode200() {
    let baseUrl = "http://thecatapi.com/api/images/favorite?api_key=\(apiKey)&sub_id=siwook&image_id=act"
    let undoMarkFavoriteQuery = "&action=remove"

    let url = URL(string: baseUrl + undoMarkFavoriteQuery)
    let promise = expectation(description: "Status code: 200")

    let dataTask = sessionUnderTest.dataTask(with: url!) { _, response, error in
      if let error = error {
        XCTFail("\(error.localizedDescription)")
      } else if let httpResponse = response as? HTTPURLResponse {
        if 200..<300 ~= httpResponse.statusCode {
          promise.fulfill()
        }
      }
    }

    dataTask.resume()
    waitForExpectations(timeout: 5, handler: nil)
  }

}
