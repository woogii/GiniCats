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
  @IBOutlet weak var leftBarButtonItemMenu: UIBarButtonItem!
  fileprivate var catImageInfoList = [CatImageInfo]()
  fileprivate let restClient = RestClient()
  private let refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(CatImageListCollectionViewController.handleRefresh(_:)),
                             for: UIControlEvents.valueChanged)
    return refreshControl
  }()
  private var isRefreshing = false

  override func viewDidLoad() {
    super.viewDidLoad()

    configureSideMenu()
    fetImageInfo()
    addRefreshControl()
  }

  // MARK : - Configure RefreshControl
  private func addRefreshControl() {
    if #available(iOS 10.0, *) {
      collectionView?.refreshControl = refreshControl
    } else {
      collectionView?.addSubview(refreshControl)
    }
  }

  // MARK : - RefreshControl Action
  func handleRefresh(_ refreshControl: UIRefreshControl) {
    isRefreshing = true
    fetImageInfo()
  }

  // MARK : - Configure Side Menu
  private func configureSideMenu() {
    guard revealViewController() != nil else { return }

    leftBarButtonItemMenu.target = revealViewController()
    leftBarButtonItemMenu.action = #selector(SWRevealViewController.revealToggle(_:))
    revealViewController().rearViewRevealWidth = (self.view.frame.size.width*2)/3
    view.addGestureRecognizer(revealViewController().panGestureRecognizer())
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
      DispatchQueue.main.async {
        self?.collectionView?.reloadData()
        if self?.isRefreshing == true {
          self?.refreshControl.endRefreshing()
        }
      }
    })
  }

}

// MARK : - CatImageListCollectionViewController Extension
extension CatImageListCollectionViewController {

  // MARK: UICollectionView DataSource Method List
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return catImageInfoList.count
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellID.CatImage,
                                                        for: indexPath) as? CatImageCollectionViewCell else {
                                                          fatalError(Constants.FatalError.UnExpectedCollectionViewCell)
    }
    configureCell(cell, at: indexPath)
    return cell
  }

  // MARK: - Configure Cell
  private func configureCell(_ cell: CatImageCollectionViewCell, at indexPath: IndexPath) {

    // Trigger cell UI Update
    cell.catImageInfo = self.catImageInfoList[indexPath.row]

    // Define favorite button action closure
    cell.favoriteButtonTapAction = { [unowned self] in
      self.catImageInfoList[indexPath.row].isFavorite = !self.catImageInfoList[indexPath.row].isFavorite
      // Favoring Cat
      self.setFavoriteCatImage(self.catImageInfoList[indexPath.row])
      // Trigger cell UI Update
      cell.catImageInfo = self.catImageInfoList[indexPath.row]
    }
  }

  // MARK : - Set Favorite Cat UI & API Request
  private func setFavoriteCatImage(_ catImageInfo: CatImageInfo) {
    let isFavorite = catImageInfo.isFavorite
    let imageId = catImageInfo.imageId
    // Favoring Cat via API Request
    restClient.requestFavoringImageBasedOn(isFavorite: isFavorite, imageId: imageId) { (errorMessage) in
      print("error : \(errorMessage as Any)")
    }
  }
}

// MARK : - CatImageListCollectionViewController Extension
extension CatImageListCollectionViewController: UICollectionViewDelegateFlowLayout {

  // MARK : - UICollectionViewDelegateFlowLayout Method List
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {

    let paddingSpace = Constants.SectionInsets.left * (Constants.NumberOfItems + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / Constants.NumberOfItems

    return CGSize(width: widthPerItem, height: Constants.CellHeight)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return Constants.SectionInsets
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Constants.SectionInsets.left
  }
}
