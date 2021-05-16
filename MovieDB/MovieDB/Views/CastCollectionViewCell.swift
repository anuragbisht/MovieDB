//
//  CastCollectionViewCell.swift
//  MovieDB
//
//  Created by Vikram Bisht on 5/15/21.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
  static let identifier  = "CastCollectionViewCell";
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var roleLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  func setData(cast:Cast){
    nameLabel.text = cast.name ?? ""
    roleLabel.text = cast.character ?? ""
    guard let url  = URL(string: "\(Urls.imageBaseUrl)\(cast.profilePath ?? "")")  else {return}
    imageView.sd_setImage(with: url , completed: nil)
  }
}
