//
//  Bubble.swift
//  bubble-pop-swift-uikit
//
//  Created by Andrew Vo-Nguyen on 20/4/21.
//

import UIKit

class Bubble: UIButton {
    init(bubbleSize: Int, availablePositions: [(x: Int, y: Int)]) {
        super.init(frame: .zero)
        //Use any randome x,y co-ordinates from availablePositions
        let randomIndex = Int.random(in: 0...availablePositions.count - 1)
        //Get x,y tuple from array
        let newPosition: (x: Int, y: Int) = availablePositions[randomIndex]
        //Set the bubble's unique position
        self.frame = CGRect(x: newPosition.x, y: newPosition.y, width: bubbleSize, height: bubbleSize)
        //Styling of the bubble
        self.backgroundColor = .blue
        self.layer.cornerRadius = self.bounds.size.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
