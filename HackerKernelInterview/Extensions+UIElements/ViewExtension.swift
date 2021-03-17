//
//  ViewExtension.swift
//  HackerKernelInterview
//
//  Created by apple on 16/03/21.
//

import Foundation
import UIKit

@IBDesignable
class CardViewss: UIView {
    
    @IBInspectable var cornerRadius:CGFloat = 0.0
    @IBInspectable var ofSetWidth:CGFloat = 0.0
    @IBInspectable var ofSetHeight:CGFloat = 0.0
    @IBInspectable var ofSetShadowOpacity:Float = 1.0
    @IBInspectable var color:UIColor = UIColor.clear
    @IBInspectable var borderColor: UIColor? = UIColor.clear
    @IBInspectable var borderWidth: CGFloat = 0.0
    
    override func layoutSubviews() {
        layer.borderWidth = self.borderWidth
        layer.borderColor = self.borderColor?.cgColor
        layer.cornerRadius = self.cornerRadius
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: ofSetWidth, height: ofSetHeight)
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: self.cornerRadius).cgPath
        layer.shadowOpacity = self.ofSetShadowOpacity
    }

}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func roundedCorners(corners : CACornerMask, radius : CGFloat) {
        self.layer.maskedCorners = corners
        self.layer.masksToBounds = false
        self.layer.cornerRadius = radius
        
    }

}
