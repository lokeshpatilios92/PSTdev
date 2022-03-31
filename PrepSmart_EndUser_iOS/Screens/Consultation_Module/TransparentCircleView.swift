//
//  TransparentCircleView.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sanket ETPL on 13/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class TransparentCircleView: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    var radius: CGFloat = 46 { didSet { updateMask() } }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateMask()
    }
    
    
    private func updateMask() {
        let path = UIBezierPath()
        path.move(to: bounds.origin)
        let center = CGPoint(x: bounds.maxX - 33, y: bounds.maxY - 33
        )
        path.addArc(withCenter: center, radius: radius, startAngle: .pi*2, endAngle: 0, clockwise: false)
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        path.close()
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        
        layer.mask = mask
    }

}
