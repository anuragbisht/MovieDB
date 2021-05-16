//
//  MovieListCollectionViewCell.swift
//  MovieDB
//
//  Created by Vikram Bisht on 5/15/21.
//

import UIKit
import SDWebImage

class MovieListCollectionViewCell: UICollectionViewCell {
  static var identifier = "MovieListCollectionViewCell"
  var viewScore:MDBCircularProgress?

  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var scoreView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subTitleLabel: UILabel!
  
  override func awakeFromNib(){
        super.awakeFromNib()
        // Initialization code
    imageView.layer.cornerRadius = CGFloat.radius4;
    viewScore = MDBCircularProgress(number: 2, frame: scoreView.bounds)
    scoreView.addSubview(viewScore!)
  }
  
  func setData(movie:Movie){
    titleLabel.text = movie.title;
    subTitleLabel.text = movie.releaseDate;
    viewScore?.setData(number: movie.voteAverage ?? 0)
    guard  let url = movie.imagePosterUrl else {return}
    imageView.sd_setImage(with: url, completed: nil);
  }
  
  override func prepareForReuse() {
    super.prepareForReuse();
    titleLabel.text = ""
    subTitleLabel.text = ""
    viewScore?.setData(number: 0);
  }
}
