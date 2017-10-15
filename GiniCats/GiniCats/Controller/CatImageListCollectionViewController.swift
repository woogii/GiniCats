//
//  CatImageListCollectionViewController.swift
//  GiniCats
//
//  Created by siwook on 2017. 10. 15..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - CatImageListCollectionViewController: UICollectionViewController
class CatImageListCollectionViewController: UICollectionViewController {

  // MARK : - Property List
  fileprivate var catImageInfoList = [CatImageInfo]()
  fileprivate let restClient = RestClient()

  override func viewDidLoad() {
    super.viewDidLoad()
    fetImageInfo()
  }

  // MARK : - Fetch Image Information
  private func fetImageInfo() {
    restClient.requestCatImageInfoList(completionHandler: { [weak self] (imageList, error) in
      guard error == nil else {
        print(error!.localizedDescription)
        return
      }
      guard let imageList = imageList as? [CatImageInfo] else {
        return
      }
      self?.catImageInfoList = imageList

      for i in 0..<imageList.count {
        print("item[\(i)] : \(imageList[i].url)")
      }
      DispatchQueue.main.async {
        self?.collectionView?.reloadData()
      }
    })
  }

}

// MARK : - CatImageListCollectionViewController Extension
extension CatImageListCollectionViewController {

  // MARK: UICollectionView DataSource Method List
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellID.CatImage,
                                                        for: indexPath) as? CatImageCollectionViewCell else {
                                                          fatalError(Constants.FatalError.UnExpectedCollectionViewCell)
    }

    return cell
  }
}
