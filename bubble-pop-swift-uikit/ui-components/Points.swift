//
//  Points.swift
//  bubble-pop-swift-uikit
//
//  Created by Andrew Vo-Nguyen on 26/4/21.
//

import UIKit

class Points: UILabel {
    init(frame: CGRect, points: Int) {
        super.init(frame: frame)
        self.text = "+\(points)"
        self.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)
        //Animate the points to show on the screen
        self.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.25, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: { (success) in
            if (success) {
                //When compelte, fade animation to leave screen
                UIView.animate(withDuration: 0.5, animations: {
                    self.alpha = 0
                }, completion: { (success) in
                    if (success) {
                        //Once fade is finished, remove from parent view
                        self.removeFromSuperview()
                    }
                })
                
            }
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
