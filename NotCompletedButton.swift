//
//  NotCompletedButton.swift
//  QuickReminder
//
//  Created by Michal Vranec on 17/07/2017.
//  Copyright © 2017 Michal Vranec. All rights reserved.
//

import UIKit


@IBDesignable
class NotCompletedButton: UIButton {

    @IBInspectable var completed: Bool = false
    @IBInspectable var fillColor: UIColor = UIButton(type: .system).currentTitleColor
    
    override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath(ovalIn: rect.insetBy(dx: 1, dy: 1))
        if(completed){
            fillColor.setFill()
            circlePath.fill()
        }
        UITableView().separatorColor?.setStroke()
        circlePath.lineWidth = 1
        circlePath.stroke()
        
        if(completed){
            let checkSymbol = UIBezierPath()
            checkSymbol.lineWidth = 2
            checkSymbol.move(to: CGPoint(x: 8, y: 15))
            checkSymbol.addLine(to: CGPoint(x: 13.17, y: 20.25))
            checkSymbol.addLine(to: CGPoint(x: 22, y: 10))
            UIColor.white.setStroke()
            checkSymbol.stroke()
        }
        
    }
}
