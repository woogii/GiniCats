//
//  FavoriteCatListViewController.swift
//  GiniCats
//
//  Created by siwook on 2017. 10. 15..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - FavoriteCatListViewController: UIViewController
class FavoriteCatListViewController: UIViewController {

  // MARK : - Property List
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
  fileprivate let restClient = RestClient()
  fileprivate var favoriteCatInfoList = [FavoriteCatImageInfo]()

  // MARK : - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchFavoriteCatList()
  }

  // MARK : - Fetch Favorite Cat List
  private func fetchFavoriteCatList() {
    restClient.requestFavoriteCatImageInfoList(completionHandler: { [weak self] (imageInfoList, error) in
      guard error == nil else {
        print(error!.localizedDescription)
        return
      }
      guard let imageInfoList = imageInfoList as? [FavoriteCatImageInfo] else {
        return
      }
      self?.favoriteCatInfoList = imageInfoList
      DispatchQueue.main.async {
        self?.tableView?.reloadData()
      }
    })
  }
  // MARK : - Action Method
  @IBAction func tapCloseBarButtonItem(_ sender: UIBarButtonItem) {
    // Set front view controller's position to left
    self.dismiss(animated: true, completion: nil)
  }
}

// MARK : - FavoriteCatListViewController : UITableViewDataSource
extension FavoriteCatListViewController: UITableViewDataSource {

  // MARK : - UITableViewDataSource Method List
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favoriteCatInfoList.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellID.FavoriteCatImage,
                                                   for: indexPath) as? FavoriteCatImageTableViewCell else {
                                                    fatalError(Constants.FatalError.UnExpectedTableViewCell)
    }
    cell.catImageInfo = favoriteCatInfoList[indexPath.row]
    return cell
  }
}
