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
    
    
    let DEFAULT_SIZE: Int = 50
    var timer = Timer()
    var name:String = ""
    var activeBubbles: [Bubble] = []
    var allPositions: [(x: Int, y: Int)] = []
    var availablePositions: [(x: Int, y: Int)] = []
    
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
            timeRemaining = gameDuration
        }
    }
    var maxBubbles:Int = 15
    var score:Int = 0 {
        didSet {
            ScoreCounterLabel.text = String(score)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in
            self.countingDown()
            self.clearBubbles()
            self.createBubbles()
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
        ScoreCounterLabel.textAlignment = .center
        
        //Initialize all positions depending on screen width and height
        let availableWidth = Int(PlayAreaView.frame.width) - DEFAULT_SIZE
        let availableHeight = Int(PlayAreaView.frame.height) - DEFAULT_SIZE
        for x in 0...availableWidth {
            for y in 0...availableHeight {
                allPositions.append((x, y))
            }
        }
        
    }
    
    @objc func countingDown() {
        timeRemaining -= 1
        
        if (timeRemaining == 0) {
            timer.invalidate()
            timeRemaining = gameDuration
        }
    }
    
    func clearBubbles() -> Void {
        for bubble in activeBubbles {
            bubble.removeFromSuperview()
        }
        //Reset active bubbles
        activeBubbles = []
        //Reset available positions
        availablePositions = allPositions
    }
    
    func createBubbles() -> Void {
        //Generate a random amount of bubbles, min = 1, max = maxBubbles setting
        let numberOfBubbles = Int.random(in: 1...maxBubbles)
        for _ in 1...numberOfBubbles {
            //Create new bubble, send through bubbleSize and current list of available co-ordinates
            let bubble  = Bubble(bubbleSize: DEFAULT_SIZE, availablePositions: availablePositions)
            
            //Get bubbles, x,y, width and height generated from init()
            let bubbleHeight = Int(bubble.frame.height)
            let bubbleWidth = Int(bubble.frame.width)
            let bubbleXPosition = Int(bubble.frame.origin.x)
            let bubbleYPosition = Int(bubble.frame.origin.y)

            //Remove all co-ordinates occupied by this bubble from availablePositions array
            let newAvailablePositions: [(x: Int, y: Int)] = availablePositions.filter { (currentPosition) -> Bool in
                !(currentPosition.x >= (bubbleXPosition - bubbleWidth) && currentPosition.x <= (bubbleXPosition + bubbleWidth) && currentPosition.y >= (bubbleYPosition - bubbleHeight) && currentPosition.y <= (bubbleYPosition + bubbleHeight))
            }
            availablePositions = newAvailablePositions
            
            //Add listener for bubble to be touched
            bubble.addTarget(self, action: #selector(onBubblePressed), for: .touchUpInside)
            
            //Add to PlayArea UiView
            PlayAreaView.addSubview(bubble)
            
            //Add to activeBubbles array so that it can be removed from the SuperView after 1 second
            activeBubbles.append(bubble)
        }

    }
    
    @IBAction func onBubblePressed(_ sender: Bubble) {
        addPointsToScore(points: sender.points)
        sender.removeFromSuperview()
    }
    
    func addPointsToScore(points: Int) -> Void {
        print(points)
        score += points
    }
}
