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
        super.init(frame: CGRect(x: x, y: y, width: bubbleSize, height: bubbleSize))
        
        //Get random generated bubble properties
        let buttonProperties: (color: UIColor, points: Int) = getBubbleProperties()
        points = buttonProperties.points
        color = buttonProperties.color
        
        //Styling of the bubble
        self.backgroundColor = buttonProperties.color
        self.layer.cornerRadius = self.bounds.size.width / 2
        self.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        //Animate the entering of a bubble scale from 0 to 1
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1
            )
        }, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func remove(duration: Double, location: (x: CGFloat, y: CGFloat)) {
        let currentWidth = self.frame.width
        let currentHeight = self.frame.height
        
        self.alpha = 0.1
        //Animate the movement of the bubble to go off screen
        UIView.animate(withDuration: duration) {
            self.frame = CGRect(x: location.x, y: location.y, width: currentWidth, height: currentHeight)
        } completion: { (success) in
            if (success) {
                self.pop(onComplete: {})
            }
        }
    }
    
    //Animate the popping of a bubble and remove from superview after animation is complete
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
    
    //Change position if there is an overlap
    func changePosition(x: Int, y: Int) -> Void {
        self.frame.origin.x = CGFloat(x)
        self.frame.origin.y = CGFloat(y)
    }
    
    //Determine if self is overlapping with another bubble
    func isOverlapping(bubble: Bubble) -> Bool {
        return self.frame.intersects(bubble.frame)
    }
    
    //Return color and points associated with this bubble
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
