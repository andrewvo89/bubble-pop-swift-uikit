//
//  GameScreenViewController.swift
//  bubble-pop-swift-uikit
//
//  Created by Andrew Vo-Nguyen on 18/4/21.
//


import UIKit

class GameScreenViewController: UIViewController {
    @IBOutlet weak var TopPanelCard: UIView!
    @IBOutlet weak var PlayAreaView: UIView!
    @IBOutlet weak var TimeTitleLabel: UILabel!
    @IBOutlet weak var TimeCounterLabel: UILabel!
    @IBOutlet weak var ScoreTitleLabel: UILabel!
    @IBOutlet weak var ScoreCounterLabel: UILabel!
    var timer = Timer()
    var name:String = ""
    var timeRemaining:Int = 60 {
        didSet {
            //First variable change from parent segue, the UI is not initialized
            if (TimeCounterLabel != nil) {
                TimeCounterLabel.text = String(timeRemaining)
            }
        }
    }
    var gameDuration:Int = 60 {
        didSet {
            print("gameDuration \(gameDuration)")
            timeRemaining = gameDuration
        }
    }
    var maxBubbles:Int = 15
    
    override func viewDidLoad() {
        print(name)
        print(gameDuration)
        print(maxBubbles)
        super.viewDidLoad()
        initialize()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in
            self.countingDown()
            self.createBubble()
        }
        // Do any additional setup after loading the view.
    }
    
    func initialize() -> Void {
        //Set card styles for game options card
        TopPanelCard.layer.borderWidth = 1
        TopPanelCard.layer.borderColor = UIColor.black.cgColor
        TopPanelCard.layer.cornerRadius = 8
        TopPanelCard.layer.shadowColor = UIColor.black.cgColor
        TopPanelCard.layer.shadowOpacity = 0.6
        TopPanelCard.layer.shadowOffset = .init(width: 3, height: 3)
        TopPanelCard.layer.shadowRadius = 3
        
        //Time labels
        TimeTitleLabel.text = "Time"
        TimeTitleLabel.textAlignment = .center
        TimeCounterLabel.textAlignment = .center
        TimeCounterLabel.text = String(timeRemaining)
        
        //Score labels
        ScoreTitleLabel.text = "Score"
        ScoreTitleLabel.textAlignment = .center
        ScoreCounterLabel.text = "0"
        ScoreCounterLabel.textAlignment = .center
    }
    
    @objc func countingDown() {
        timeRemaining -= 1
        
        if (timeRemaining == 0) {
            timer.invalidate()
            timeRemaining = gameDuration
        }
    }
    
    func createBubble() -> Void {
        print("create bubble")
        let bubble = Bubble()
        bubble.addTarget(self, action: #selector(onBubblePressed), for: .touchUpInside)
        self.view.addSubview(bubble)
    }
    
    @IBAction func onBubblePressed(_ sender: UIButton) {
        sender.removeFromSuperview()
    }
}
