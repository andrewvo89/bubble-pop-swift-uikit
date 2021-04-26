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
        
        self.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1
            )
        }, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    func spring() {
//        let springAnimation = CASpringAnimation(keyPath: "transform.scale")
//        springAnimation.duration = 0.6
//        springAnimation.fromValue = 1
//        springAnimation.toValue = 0.8
//        springAnimation.repeatCount = 1
//        springAnimation.initialVelocity = 0.5
//        springAnimation.damping = 1
//        layer.add(springAnimation, forKey: nil)
//    }
    
    func remove(duration: Double, location: (x: CGFloat, y: CGFloat)) {
        let currentWidth = self.frame.width
        let currentHeight = self.frame.height
        
        self.alpha = 0.1
        UIView.animate(withDuration: duration) {
            self.frame = CGRect(x: location.x, y: location.y, width: currentWidth, height: currentHeight)
        } completion: { (success) in
            if (success) {
                self.pop(onComplete: {})
            }
        }
    }
    
    func pop(onComplete: @escaping () -> Void) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1
            )
            self.alpha = 0.2
        }, completion: { success in
            if (success) {
                self.removeFromSuperview()
                onComplete()
            }
        })
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
