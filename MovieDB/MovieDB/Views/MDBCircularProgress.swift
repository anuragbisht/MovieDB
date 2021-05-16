//
//  MDBCircularProgress.swift
//  MovieDB
//
//  Created by Vikram Bisht on 5/14/21.
//

import UIKit


class MDBCircularProgress:UIView{
  private var circularPath:UIBezierPath?
  private var shapeLayer:CAShapeLayer?
  private var countLabel:UILabel?
  
  
  init(number:CGFloat, frame:CGRect) {
    super.init(frame: frame);
    setUpView();
  }
  
  required init?(coder: NSCoder) {
    
    super.init(coder: coder)
    setUpView();
  }
  func setUpView(){
    
    
    shapeLayer = CAShapeLayer();
    circularPath = UIBezierPath(arcCenter: center, radius: bounds.width/2, startAngle: (CGFloat.pi/180) * (-90) , endAngle: (CGFloat.pi/180)*270, clockwise: true);
    shapeLayer?.fillColor = Colors.translucentBlack.cgColor;
    shapeLayer?.path = circularPath?.cgPath;
    shapeLayer?.strokeColor = UIColor.red.cgColor;
    shapeLayer?.lineWidth = 3;
    shapeLayer?.strokeEnd = 0.5;
    shapeLayer?.lineCap = .round;
    
    countLabel = UILabel()
    countLabel?.frame = frame
    countLabel?.textAlignment = .center
    countLabel?.textColor = .white

    backgroundColor = .clear;
    layer.addSublayer(shapeLayer!);
    self.addSubview(countLabel!);
    
  }
  func setData(number:Float){
    countLabel?.text = number.description;
    let color:UIColor = getColor(number: number)
    shapeLayer?.strokeColor = color.cgColor;
    shapeLayer?.strokeEnd = CGFloat(number/10);
  }
  func getColor(number:Float) -> UIColor{
    if number >= 0 && number < 2.5{
      return Colors.red
    }else if number >= 2.5 && number < 5{
      return Colors.orange
    }else if number >= 5 && number < 7.5{
      return Colors.lightGreen;
    }else{
      return Colors.darkGreen;
    }
    
  }
  
}

