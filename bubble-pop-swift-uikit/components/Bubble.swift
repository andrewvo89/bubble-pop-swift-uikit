//
//  Bubble.swift
//  bubble-pop-swift-uikit
//
//  Created by Andrew Vo-Nguyen on 20/4/21.
//

import UIKit

class Bubble: UIButton {
    let x = Int.random(in: 20...400)
    let y = Int.random(in: 20...800)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .blue
        self.frame = CGRect(x: x, y: y, width: 50, height: 50)
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
