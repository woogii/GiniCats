//
//  RestClientConvenience.swift
//  GiniCats
//
//  Created by siwook on 2017. 10. 15..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK : - RestClient Extension (Convenience Method List)
extension RestClient {

  // MARK : - Type Alias List
  typealias ImageRequestResult = (_ imageInfoList: [Any]?, _ error: Error?) -> Void
  typealias FavoriteResult = (_ responseMessage: String?) -> Void

  // MARK: - Request CatImageInfo List
  func requestCatImageInfoList(completionHandler: @escaping ImageRequestResult) {

    let urlString = Constants.API.BaseURL + Constants.API.Methods.GetImages
    let queryParameters = [Constants.API.QueryItem.APIKey: Constants.API.QueryItem.APIValue,
                           Constants.API.QueryItem.FormatKey: Constants.API.QueryItem.FormatValue,
                           Constants.API.QueryItem.ResultsPerPageKey: Constants.API.QueryItem.ResultsPerPageValue]

    guard let requestUrl = constructAPIRequestUrl(urlString, queryParameters: queryParameters) else {
      return
    }

    taskForResource(with: requestUrl) { (xmlInfo, error) in
      if let error = error {
        completionHandler(nil, error)
      } else {

        guard let xmlInfo = xmlInfo else { return }

        var catImageInfoList = [CatImageInfo]()
        for elem in xmlInfo[Constants.API.XMLParsingKeys
          .Response][Constants.API.XMLParsingKeys
            .Data][Constants.API.XMLParsingKeys
              .Images][Constants.API.XMLParsingKeys
                .Image].all {
                  let currentUrl       = elem[Constants.API.XMLParsingKeys.Url].element?.text
                  let currentImageId   = elem[Constants.API.XMLParsingKeys.ImageId].element?.text
                  let currentSourceUrl = elem[Constants.API.XMLParsingKeys.SourceUrl].element?.text

                  do {
                    let imageInfo = try CatImageInfo(url: currentUrl,
                                                     imageId: currentImageId,
                                                     sourceUrl: currentSourceUrl,
                                                     isFavorite: false)
                    catImageInfoList.append(imageInfo)
                  } catch let error as NSError {
                    print("\(error.userInfo)\(error.localizedDescription)")
                  }
        }
        completionHandler(catImageInfoList, nil)
      }
    }
  }
}

// MARK : - RestClient Extension
extension RestClient {
  // MARK : - Construct URL
  func constructAPIRequestUrl(_ urlString: String, queryParameters: [String:String]) -> URL? {
    guard var urlComponent = URLComponents(string: urlString) else {
      return nil
    }
    urlComponent.queryItems = [URLQueryItem]()
    for (key, value) in queryParameters {
      let urlQueryItem = URLQueryItem(name: key, value: value)
      urlComponent.queryItems?.append(urlQueryItem)
    }
    return urlComponent.url
  }
}
