//
//  ListMoviesVC.swift
//  MovieDB
//
//  Created by Vikram Bisht on 5/15/21.
//

import UIKit

class MDBListMoviesVC: UIViewController {
  var collectionView:UICollectionView?
  let layout = UICollectionViewFlowLayout()
  var page:Int  = 1;
  var listMoviesVM:ListMoviesViewModel = ListMoviesViewModel()

  
  override func viewDidLoad() {
    
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 20
    layout.minimumInteritemSpacing = 20
    layout.sectionInset = UIEdgeInsets.init(top: 10, left: 20, bottom: 10, right: 20)
    layout.itemSize = CGSize.init(width: view.bounds.width/2 - 30, height: view.bounds.height/2 )
    
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout);
    collectionView?.backgroundColor = .white
    collectionView?.delegate = self;
    collectionView?.dataSource  = self;
    collectionView?.register(UINib.init(nibName: MovieListCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier);
    
    listMoviesVM.refreshViewClosure = {[weak self] result in
      DispatchQueue.main.async { [weak self] in
        self?.collectionView?.reloadData()
      }
    }
    listMoviesVM.showAlertClosure = { [weak self] message in
      self?.showAlert(message: message)
    }
    listMoviesVM.getListOfMovies(shouldPaginate: false);
    view.addSubview(collectionView!);
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    navigationController?.navigationBar.prefersLargeTitles = true
  }
}

extension MDBListMoviesVC:UICollectionViewDelegate, UICollectionViewDataSource{
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1;
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return listMoviesVM.listOfMovies.count;
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identifier, for: indexPath) as? MovieListCollectionViewCell else {return UICollectionViewCell()};
    cell.setData(movie: listMoviesVM.listOfMovies[indexPath.row]);
    return cell;
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let vc  = storyboard?.instantiateViewController(identifier: MDBMovieDetailVC.identifier) as? MDBMovieDetailVC , let movieID = listMoviesVM.listOfMovies[indexPath.row].id  else { return };
    let vm = MovieDetailViewModel(id: movieID)
    vc.viewmodel = vm;
    navigationController?.pushViewController(vc, animated: true);
  }
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if(indexPath.row == listMoviesVM.listOfMovies.count - 3){
      listMoviesVM.getListOfMovies(shouldPaginate: true)
    }
    
  }
}
