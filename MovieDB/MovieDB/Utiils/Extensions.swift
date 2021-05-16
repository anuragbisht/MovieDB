//
//  Extensions.swift
//  MovieDB
//
//  Created by Vikram Bisht on 5/17/21.
//

import UIKit



//MARK: CORNER RADIUS
extension CGFloat{
  static var radius4:CGFloat {
    return 4;
  }
}


//MARK: SPINER

var activityIndicator: UIActivityIndicatorView?

extension UIView{
  func addSpinner(vc:UIViewController){
    
    activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator?.center = self.center;
    activityIndicator?.startAnimating()
    vc.view.addSubview(activityIndicator ?? UIActivityIndicatorView())
    
  }
  func removeSpinner(){
    DispatchQueue.main.async {
      activityIndicator?.removeFromSuperview()
      activityIndicator = nil
    }
  }
}




//MARK: POPUP

var popUpView:UIView?
var overlayView:UIView?


extension UIViewController{
  
  func showPopUpWithMessage(message:String){
    DispatchQueue.main.async {[weak self] in
      overlayView = UIView(frame: self?.view.bounds ?? CGRect.zero);
      overlayView?.alpha = 0.8;
      overlayView?.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.8)
      
      popUpView = UIView(frame: CGRect(x: self?.view.center.x ?? 100 - 100, y: self?.view.center.y ?? 100 - 100, width: 200, height: 200))
      popUpView?.backgroundColor = UIColor(red: 0.8, green: 0.5, blue: 0.5, alpha: 1)
      popUpView?.center = overlayView?.center ?? CGPoint.zero
      
      let messageLabel = UILabel(frame: CGRect(x: (popUpView?.bounds.width ?? 50)/2  - 50 , y: (popUpView?.bounds.height ?? 50)/2 - 50 , width: 100, height: 100))
      messageLabel.textColor  = UIColor.white
      messageLabel.text = message
      messageLabel.numberOfLines = 0;
      messageLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
      
      
      let gestureRecognizer:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self?.removePopup))
      
      popUpView?.addSubview(messageLabel)
      popUpView?.addGestureRecognizer(gestureRecognizer)
      overlayView?.addGestureRecognizer(gestureRecognizer)
      self?.view.addSubview(overlayView ?? UIView())
      self?.view.addSubview(popUpView ?? UIView())
    }
    
  }
  
  @objc func removePopup(){
    popUpView?.removeFromSuperview()
    overlayView?.removeFromSuperview()
    overlayView = nil
    popUpView = nil
  }
  
  func showAlert(message:String){
    let alert = UIAlertController(title: "Something went wrong", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {  _ in
      
    }))
    self.present(alert, animated: true, completion: nil)
    
  }
}

