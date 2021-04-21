//
//  Bubble.swift
//  bubble-pop-swift-uikit
//
//  Created by Andrew Vo-Nguyen on 20/4/21.
//

import UIKit

class Bubble: UIButton {
    var points: Int = 0
        
    init(bubbleSize: Int, availablePositions: [(x: Int, y: Int)]) {
        super.init(frame: .zero)
        //Use any randome x,y co-ordinates from availablePositions
        let randomIndex = Int.random(in: 0...availablePositions.count - 1)
        //Get x,y tuple from array
        let newPosition: (x: Int, y: Int) = availablePositions[randomIndex]
        //Set the bubble's unique position
        self.frame = CGRect(x: newPosition.x, y: newPosition.y, width: bubbleSize, height: bubbleSize)
        
        //Get random generated bubble properties
        let buttonProperties: (color: UIColor, points: Int) = getBubbleProperties()
        
        points = buttonProperties.points
        //Styling of the bubble
        self.backgroundColor = buttonProperties.color
        self.layer.cornerRadius = self.bounds.size.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
