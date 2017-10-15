//
//  FavoriteCatImageTableViewCell.swift
//  GiniCats
//
//  Created by siwook on 2017. 10. 15..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import SDWebImage

// MARK : - FavoriteCatImageTableViewCell: UICollectionViewCell
class FavoriteCatImageTableViewCell: UITableViewCell {

  // MARK : - Property List
  @IBOutlet weak var backgroundCardView: UIView!
  @IBOutlet weak var catImageView: UIImageView!
  @IBOutlet weak var imageIdLabel: UILabel!
  @IBOutlet weak var timeInfoLabel: UILabel!

  var catImageInfo: FavoriteCatImageInfo! {
    didSet {
      updateUI()
    }
  }
  private let dateFormatter: DateFormatter = {
    let dateFormater = DateFormatter()
    dateFormater.locale = Locale(identifier: Constants.TimeAgoDateFormatLocalIdentifier)
    dateFormater.dateFormat = Constants.TimeAgoDateFormat
    return dateFormater
  }()

  // MARK : - Prepare For Reusing Cell
  override func prepareForReuse() {
    super.prepareForReuse()
    catImageView.sd_cancelCurrentImageLoad()
  }

  // MARK : - Update Cell UI
  private func updateUI() {
    initCellProperty()
    setCatImage()
    setImageIdLabel()
    setCatImageViewCornerRadius()
    setBackgroundCardViewCornerRadius()
    setTimeInfoLabel()
  }

  private func setTimeInfoLabel() {
    timeInfoLabel.text = dateFormatter.date(from:catImageInfo.createdAt)?.timeAgoDisplay()
  }

  private func initCellProperty() {
    // Initialize catImageView
    catImageView.image = nil
  }

  private func setCatImageViewCornerRadius() {
    catImageView.layer.masksToBounds = true
    catImageView.layer.cornerRadius  = self.catImageView.frame.width/2
  }

  private func setBackgroundCardViewCornerRadius() {
    backgroundCardView.layer.cornerRadius  = Constants.CardViewCornerRadius
    backgroundCardView.layer.masksToBounds = true
  }

  private func setImageIdLabel() {
    imageIdLabel.text = catImageInfo.imageId
  }

  private func setCatImage() {
    guard let imageUrl = URL(string: catImageInfo.url) else { return }

    // Fetch Image from Disk Cache
    if let image = SDImageCache.shared().imageFromDiskCache(forKey: imageUrl.absoluteString) {
      print("Cache Exist")
      catImageView.image = image
    } else {
      print("Image Not Exist")
      catImageView
        .sd_setImage(with: imageUrl, placeholderImage: nil,
                     options: SDWebImageOptions()) { (image, error, _, _) in
                      if image != nil {
                        UIView.transition(with: self.catImageView, duration: 0.3,
                                          options: .transitionCrossDissolve, animations: {
                                            DispatchQueue.main.async {
                                              self.catImageView.image = image
                                            }
                        }, completion: nil)
                      } else {
                        self.catImageView.image = UIImage(named: Constants.ImageFileName.NoImage)
                        guard let error = error else { return }
                        print(error.localizedDescription)
                      }
      }
    }
  }
}
