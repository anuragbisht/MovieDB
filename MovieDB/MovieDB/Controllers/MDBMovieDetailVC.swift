//
//  MDBMovieDetailVC.swift
//  MovieDB
//
//  Created by Vikram Bisht on 5/15/21.
//

import UIKit

class MDBMovieDetailVC: UIViewController {
  
  static let identifier = "MDBMovieDetailVCIdentifier"
  var viewmodel: MovieDetailViewModel?
  
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var releaseDateLabel: UILabel!
  
  @IBOutlet weak var durationLabel: UILabel!
  
  @IBOutlet weak var castCollectionView: UICollectionView!
  @IBOutlet weak var backGroundImageView: UIImageView!
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var scoreView: MDBCircularProgress!
  @IBOutlet weak var genreLabel: UILabel!
  @IBOutlet weak var overviewLabel: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.prefersLargeTitles = false
    castCollectionView.register(UINib.init(nibName: CastCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CastCollectionViewCell.identifier)
    castCollectionView.delegate = self
    castCollectionView.dataSource = self
    viewmodel?.showAlertClosure = { [weak self] message in
      self?.showAlert(message: message);
    }
    viewmodel?.refreshViewClosure = { [weak self] in
      self?.setData()
      self?.view.removeSpinner()
    }
    self.view.addSpinner(vc: self)
    viewmodel?.getCredits()
    viewmodel?.getDetailsOfMovie()
  }
  func setData(){
    castCollectionView.reloadData()
    titleLabel.text = viewmodel?.movie?.title
    releaseDateLabel.text = viewmodel?.movie?.releaseDate
    durationLabel.text = "\(viewmodel?.movie?.runtime?.description ?? "") min"
    genreLabel.text = viewmodel?.movie?.genres?.reduce("", { curr, gen in
      if(curr == ""){
        return "\(gen.name ?? "")";
      }
      return "\(curr ?? "") , \(gen.name ?? "")";
    })
    overviewLabel.text = viewmodel?.movie?.overview
    scoreView.setData(number: viewmodel?.movie?.voteAverage ?? 0)
    guard let backUrl = URL(string: "\(Urls.imageBaseUrl)\(viewmodel?.movie?.backdropPath ?? "")") else {
      return
    }
    backGroundImageView.sd_setImage(with: backUrl, completed: nil)
      
    guard let posterUrl = URL(string: "\(Urls.imageBaseUrl)\(viewmodel?.movie?.posterPath ?? "")") else {
      return
    }
    posterImageView.sd_setImage(with: posterUrl, completed: nil)
  }
  
}
extension MDBMovieDetailVC:UICollectionViewDelegate, UICollectionViewDataSource{
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1;
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewmodel?.listOfCast.count ?? 0;
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.identifier, for: indexPath) as? CastCollectionViewCell else{
      return UICollectionViewCell()
    }
    if let cast = viewmodel?.listOfCast[indexPath.row]{
      cell.setData(cast: cast);
    }
    return cell;
  }
  
}
