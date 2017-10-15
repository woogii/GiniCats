//
//  CatImageCollectionViewCell.swift
//  GiniCats
//
//  Created by siwook on 2017. 10. 15..
//  Copyright © 2017년 siwook. All rights reserved.
//

import UIKit

// MARK : - CatImageCollectionViewCell: UICollectionViewCell
class CatImageCollectionViewCell: UICollectionViewCell {
  // MARK : - Property List
  @IBOutlet weak var imageIdLabel: UILabel!
  @IBOutlet weak var catImageView: UIImageView!
  @IBOutlet weak var favoriteButton: UIButton!
}
