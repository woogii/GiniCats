//
//  CatImageCollectionViewCell.swift
//  GiniCats
//
//  Created by siwook on 2017. 10. 15..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit
import SDWebImage

// MARK: - CatImageCollectionViewCell: UICollectionViewCell
class CatImageCollectionViewCell: UICollectionViewCell {
  // MARK: - Property List
  @IBOutlet weak var imageIdLabel: UILabel!
  @IBOutlet weak var catImageView: UIImageView!
  @IBOutlet weak var favoriteButton: UIButton!

  var catImageInfo: CatImageInfo! {
    didSet {
      updateUI()
    }
  }
  var favoriteButtonTapAction: (() -> Void)?

  // MARK: - Prepare For Reusing Cell
  override func prepareForReuse() {
    super.prepareForReuse()
    catImageView.sd_cancelCurrentImageLoad()
  }

  // MARK: - Target Action
  @IBAction func tappedFavoriteButton(_ sender: UIButton) {
    if let buttonAction = favoriteButtonTapAction {
      // Call Action Closure
      buttonAction()
    }
  }

  // MARK: - Update Cell UI
  private func updateUI() {
    initCellProperty()
    setCatImage()
    setImageIdLabel()
    setFavoriteButtonImage()
    setCellCornerRadius()
  }

  private func initCellProperty() {
    // Initialize catImageView and favorite button status
    catImageView.image       = nil
    favoriteButton.isEnabled = true
  }

  private func setCellCornerRadius() {
    self.layer.masksToBounds = true
    self.layer.cornerRadius  = Constants.CatCellCornerRadius
  }

  private func setImageIdLabel() {
    imageIdLabel.text = Constants.ImageIdLablePrefix + catImageInfo.imageId
  }

  private func setFavoriteButtonImage() {
    if catImageInfo.isFavorite == true {
      let image = UIImage(named: Constants.ImageFileName.FavoriteFilled)
      favoriteButton.setImage(image, for: UIControlState.normal)
    } else {
      let image = UIImage(named: Constants.ImageFileName.FavoriteEmpty)
      favoriteButton.setImage(image, for: UIControlState.normal)
    }
  }

  private func setCatImage() {
    guard let imageUrl = URL(string: catImageInfo.url) else { return }

    // Fetch Image from Memory Cache
    if let image = SDImageCache.shared().imageFromMemoryCache(forKey: imageUrl.absoluteString) {
      self.catImageView.image = image
    } else {
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
                        // Disable Favorite Button when the image is not available
                        self.favoriteButton.isEnabled = false
                        guard let error = error else { return }
                        print(error.localizedDescription)
                      }
      }
    }
  }
}
