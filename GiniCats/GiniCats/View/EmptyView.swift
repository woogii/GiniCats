//
//  EmptyView.swift
//  GiniCats
//
//  Created by siwook on 2017. 10. 19..
//  Copyright © 2017년 siwook. All rights reserved.
//

import Foundation

// MARK: - EmptyView: UIView 
class EmptyView: UIView {

  // MARK: - Property List
  private var titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.numberOfLines = 0
    titleLabel.textAlignment = .center
    return titleLabel
  }()
  let titleLabelHeight: CGFloat = 20

  // MARK: - Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.frame = frame
    self.backgroundColor = .white
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func addEmptyViewWith(text: String) {
    self.titleLabel.text = text
    self.titleLabel.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: titleLabelHeight)
    self.titleLabel.center = self.center
    self.addSubview(titleLabel)
  }
}
