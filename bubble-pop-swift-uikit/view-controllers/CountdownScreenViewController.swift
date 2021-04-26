//
//  CountdownScreenViewController.swift
//  bubble-pop-swift-uikit
//
//  Created by Andrew Vo-Nguyen on 25/4/21.
//

import UIKit

class CountdownScreenViewController: UIViewController {
    var name:String = ""
    var gameDuration:Int = 60
    var maxBubbles:Int = 15
    
    @IBOutlet weak var TimerLabel: UILabel!
    var timer = Timer()
    var timeRemaining:Int = 3 {
        didSet {
            if (timeRemaining == 0) {
                performSegue(withIdentifier: "ToGameScreenSegue", sender: nil)
            } else {
                setTimerLabel()
            }
        }
    }
    
    override func viewDidLoad() {
        initializeUI()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in
            self.timeRemaining -= 1
        }
    }
    
    
    func initializeUI() -> Void {
        TimerLabel.font = UIFont.systemFont(ofSize: 1024)
        setTimerLabel()
    }
    
    func setTimerLabel() -> Void {
        self.TimerLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
        TimerLabel.text = String(timeRemaining)
        
        UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.TimerLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ToGameScreenSegue") {
            let viewController = segue.destination as! GameScreenViewController
            viewController.name = name
            viewController.gameDuration = gameDuration
            viewController.maxBubbles = maxBubbles
            
        }
    }
}
