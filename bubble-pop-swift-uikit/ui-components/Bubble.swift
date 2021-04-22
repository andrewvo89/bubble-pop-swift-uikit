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
    
    func changePosition(x: Int, y: Int) -> Void {
        self.frame.origin.x = CGFloat(x)
        self.frame.origin.y = CGFloat(y)
    }
    
    func isOverlapping(bubble: Bubble) -> Bool {
        let selfX = Int(self.frame.origin.x)
        let selfY = Int(self.frame.origin.y)
        
        let bubbleHeight = Int(bubble.frame.height)
        let bubbleWidth = Int(bubble.frame.width)
        let bubbleX = Int(bubble.frame.origin.x)
        let bubbleY = Int(bubble.frame.origin.y)
        
        let overlappingX = selfX >= (bubbleX - bubbleWidth) && selfX <= (bubbleX + bubbleWidth)
        let overlappingY = selfY >= (bubbleY - bubbleHeight) && selfY <= (bubbleY + bubbleHeight)
        return overlappingX && overlappingY
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
