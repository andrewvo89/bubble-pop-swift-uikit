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
    var availableWidth: Int = 0
    var availableHeight: Int = 0
    var prevColor: UIColor?
    
    var timeRemaining:Int = 60 {
        didSet {
            //First variable change from parent segue, the UI is not initialized
            if (TimeCounterLabel != nil) {
                TimeCounterLabel.text = String(timeRemaining)
            }
            if (timeRemaining == 0) {
                onGameEnd()
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
            if (ScoreCounterLabel != nil) {
                ScoreCounterLabel.text = String(score)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in
            self.timeRemaining -= 1
            self.sync(lock: self.activeBubbles) {
                self.removeBubbles()
                self.createBubbles()
            }
            
        }
        // Do any additional setup after loading the view.
    }
    
    func initializeUI() -> Void {
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
        score = 0
        
        //Initialize all positions depending on screen width and height
        availableWidth = Int(PlayAreaView.frame.width) - DEFAULT_SIZE
        availableHeight = Int(PlayAreaView.frame.height) - DEFAULT_SIZE
    }
    
    func sync(lock: Any, action: () -> ()) {
        objc_sync_enter(lock)
        defer {
            objc_sync_exit(lock)
        }
        action()
    }
    
    
    func createBubbles() {
        //Can only create maximum between what's currently on the screen and the max bubbles
        let maxAddCount = maxBubbles - activeBubbles.count
        let createCount = Int.random(in: 0...maxAddCount)
        //Possible to create no bubbles on this play, return early from function
        if (createCount == 0) {
            return
        }
        //Loop through and create bubbles
        for _ in 1...createCount {
            //Default initial vales before entering repeat while loop
            var isOverlapping: Bool
            let newBubble = Bubble(x: 0, y: 0, bubbleSize: DEFAULT_SIZE)
            repeat {
                //Generate random co-ordinates
                let newX = Int.random(in: 0...availableWidth)
                let newY = Int.random(in: 0...availableHeight)
                //Move the bubble to new position
                newBubble.changePosition(x: newX, y: newY)
                //If at least one active bubble is overlapping, then iterate through this while loop again
                isOverlapping = activeBubbles.contains(where: { (currentBubble) -> Bool in
                    newBubble.isOverlapping(bubble: currentBubble)
                })
            } while (isOverlapping == true)
            //Success condition, exit loop and add bubble to the game
            activeBubbles.append(newBubble)
            newBubble.addTarget(self, action: #selector(onBubblePressed), for: .touchUpInside)
            PlayAreaView.addSubview(newBubble)
        }
    }
    
    func removeBubbles() -> Void {
        //New array of bubbles to keep
        var newActiveBubbles: [Bubble] = []
        for activeBubble in activeBubbles {
            let removeBubble = Bool.random()
            if (removeBubble) {
                //Remove from parent view
                activeBubble.removeFromSuperview()
            } else {
                //Add to new list of bubbles
                newActiveBubbles.append(activeBubble)
            }
        }
        //Points activeBubbles to newActiveBubbles array
        activeBubbles = newActiveBubbles
    }
    
    func addPointsToScore(color: UIColor, points: Int) -> Void {
        if (prevColor != nil && prevColor === color) {
//            print("x1: \(points) x1.5: \(Int(ceil(Double(points) * 1.5)))")
            score += Int(ceil(Double(points) * 1.5))
        } else {
            score += points
        }
        prevColor = color
    }
    
    @IBAction func onBubblePressed(_ sender: Bubble) {
        sync(lock: activeBubbles) {
            addPointsToScore(color: sender.color, points: sender.points)
            sender.removeFromSuperview()
            let newActiveBubbles: [Bubble] = activeBubbles.filter { (activeBubble) -> Bool in
                activeBubble.frame.origin.x != sender.frame.origin.x && activeBubble.frame.origin.y != sender.frame.origin.y
            }
            activeBubbles = newActiveBubbles
        }
    }
    
    func onGameEnd() -> Void {
        timer.invalidate()
        timeRemaining = gameDuration
        let finalScore = Score(name: name, score: score)
        finalScore.register()
        let highScores = Score.getAll()
        print("High Scores\(highScores)")
        
        //Programatically navigate to high score screen
        performSegue(withIdentifier: "toHighScoreScreenSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toHighScoreScreenSegue") {
            
        }
    }
}
