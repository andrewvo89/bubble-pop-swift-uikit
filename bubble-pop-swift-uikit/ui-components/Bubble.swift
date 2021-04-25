//
//  Bubble.swift
//  bubble-pop-swift-uikit
//
//  Created by Andrew Vo-Nguyen on 20/4/21.
//

import UIKit

class Bubble: UIButton {
    var points: Int = 0
    var color: UIColor = UIColor.red
    
    init(x: Int, y: Int, bubbleSize: Int) {
        super.init(frame: .zero)
        self.frame = CGRect(x: x, y: y, width: bubbleSize, height: bubbleSize)
        
        //Get random generated bubble properties
        let buttonProperties: (color: UIColor, points: Int) = getBubbleProperties()
        points = buttonProperties.points
        color = buttonProperties.color
        
        //Styling of the bubble
        self.backgroundColor = buttonProperties.color
        self.layer.cornerRadius = self.bounds.size.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func spring() {
        let springAnimation = CASpringAnimation(keyPath: "transform.scale")
        springAnimation.duration = 0.6
        springAnimation.fromValue = 1
        springAnimation.toValue = 0.8
        springAnimation.repeatCount = 1
        springAnimation.initialVelocity = 0.5
        springAnimation.damping = 1
        layer.add(springAnimation, forKey: nil)
    }
    
    func remove() {
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseInOut) {
            self.frame = CGRect(x: 0, y: 0, width: 200.0, height: 50.0)
            self.center = self.center
        } completion: { (Bool) in
            self.removeFromSuperview()
        }

    }
    
    func changePosition(x: Int, y: Int) -> Void {
        self.frame.origin.x = CGFloat(x)
        self.frame.origin.y = CGFloat(y)
    }
    
    func isOverlapping(bubble: Bubble) -> Bool {
        return self.frame.intersects(bubble.frame)
    }
    
    func getBubbleProperties() -> (UIColor, Int) {
        let randomPercentage = Int.random(in: 1...100)
        switch randomPercentage {
            case 1...40:
                return (UIColor.red, 1)
            case 41...70:
                return (UIColor.systemPink, 2)
            case 71...85:
                return (UIColor.green, 5)
            case 86...95:
                return (UIColor.blue, 7)
            case 96...100:
                return (UIColor.black, 10)
            default:
                return (UIColor.red, 1)
            
        }
    }
}
