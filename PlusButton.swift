//
//  PlusButton.swift
//  QuickReminder
//
//  Created by Michal Vranec on 29/07/2017.
//  Copyright © 2017 Michal Vranec. All rights reserved.
//

import UIKit

@IBDesignable
class PlusButton: UIButton {

    override func draw(_ rect: CGRect) {
        let plusWidth = min(bounds.width, bounds.height) * 0.6
        let plusPath = UIBezierPath()
        plusPath.lineWidth = 1
        
        //Horizontal Line
        plusPath.move(to: CGPoint(
            x:bounds.width/2 - plusWidth/2 + 0.5,
            y:bounds.height/2 + 0.5))
        
        plusPath.addLine(to: CGPoint(
            x:bounds.width/2 + plusWidth/2 + 0.5,
            y:bounds.height/2 + 0.5))
        
        //Vertical Line
        plusPath.move(to: CGPoint(
            x:bounds.width/2 + 0.5,
            y:bounds.height/2 - plusWidth/2 + 0.5))
        
        plusPath.addLine(to: CGPoint(
            x:bounds.width/2 + 0.5,
            y:bounds.height/2 + plusWidth/2 + 0.5))
        
        UITableView().separatorColor?.setStroke()
        plusPath.stroke()
    }

}
