//
//  GameScreenViewController.swift
//  bubble-pop-swift-uikit
//
//  Created by Andrew Vo-Nguyen on 18/4/21.
//


import UIKit

class GameScreenViewController: UIViewController {
    var name:String = ""
    var gameDuration:Int = 60
    var maxBubbles:Int = 15
    
    override func viewDidLoad() {
        print(name)
        print(gameDuration)
        print(maxBubbles)
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
