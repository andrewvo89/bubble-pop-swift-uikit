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
    @IBOutlet weak var HighScoreTitleLabel: UILabel!
    @IBOutlet weak var HighScoreLabel: UILabel!
    
    let DEFAULT_SIZE: Int = 50
    let DEFAULT_MOVEMENT_DURATION = 5
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
            self.removeBubbles()
            self.createBubbles()
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
        
        //High Score labels
        let allScores = Score.getAll()
        HighScoreTitleLabel.text = "High Score"
        HighScoreTitleLabel.textAlignment = .center
        HighScoreLabel.textAlignment = .center
        HighScoreLabel.text = String(allScores[0].score)
        
        //Score labels
        ScoreTitleLabel.text = "Your Score"
        ScoreTitleLabel.textAlignment = .center
        ScoreCounterLabel.textAlignment = .center
        score = 0
        
        //Initialize all positions depending on screen width and height
        availableWidth = Int(PlayAreaView.frame.width) - DEFAULT_SIZE
        availableHeight = Int(PlayAreaView.frame.height) - DEFAULT_SIZE
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
                //Start moving bubble off screen (scale speed depending on amount of time remaining)
                let percentageTimeRemaining = Double(timeRemaining) / Double(gameDuration)
                let duration = Double(DEFAULT_MOVEMENT_DURATION) * Double(percentageTimeRemaining)
                let location = getShortestOffScreenLocation(x: activeBubble.frame.origin.x, y: activeBubble.frame.origin.y)
                activeBubble.remove(duration: duration, location: location)
            } else {
                //Add to new list of bubbles
                newActiveBubbles.append(activeBubble)
            }
        }
        //Points activeBubbles to newActiveBubbles array
        activeBubbles = newActiveBubbles
    }
    
    func addPointsToScore(color: UIColor, points: Int) -> Int {
        var pointsAdded: Int = points
        if (prevColor != nil && prevColor === color) {
            pointsAdded = Int(ceil(Double(points) * 1.5))
        }
        score += pointsAdded
        prevColor = color
        return pointsAdded
    }
    
    @IBAction func onBubblePressed(_ sender: Bubble) {
        let pointsAdded: Int = addPointsToScore(color: sender.color, points: sender.points)
        let pointsLabel = Points(frame: sender.frame, points: pointsAdded)
        PlayAreaView.addSubview(pointsLabel)
        sender.pop {
//        sender.removeFromSuperview()
            let newActiveBubbles: [Bubble] = self.activeBubbles.filter { (activeBubble) -> Bool in
                activeBubble != sender
            }
            self.activeBubbles = newActiveBubbles
        }
    }
    
    func onGameEnd() -> Void {
        timer.invalidate()
        timeRemaining = gameDuration
        let finalScore = Score(name: name, score: score)
        finalScore.register()
        //Programatically navigate to high score screen
        performSegue(withIdentifier: "ToHighScoreScreenSegue", sender: nil)
    }
    
    func getShortestOffScreenLocation(x: CGFloat, y: CGFloat) -> (x: CGFloat, y: CGFloat) {
        let locations: [(x: CGFloat, y: CGFloat)] = [
            (-CGFloat(DEFAULT_SIZE), -CGFloat(DEFAULT_SIZE)),
            (CGFloat(availableWidth) / CGFloat(2.0), -CGFloat(DEFAULT_SIZE)),
            (CGFloat(availableWidth) + CGFloat(DEFAULT_SIZE), -CGFloat(DEFAULT_SIZE)),
            (-CGFloat(DEFAULT_SIZE), CGFloat(availableHeight) / CGFloat(2.0)),
            (CGFloat(availableWidth) + CGFloat(DEFAULT_SIZE), CGFloat(availableHeight) / CGFloat(2.0)),
            (-CGFloat(DEFAULT_SIZE), CGFloat(availableHeight) + CGFloat(DEFAULT_SIZE)),
            (CGFloat(availableWidth) / CGFloat(2.0), CGFloat(availableHeight) + CGFloat(DEFAULT_SIZE)),
            (CGFloat(availableWidth) + CGFloat(DEFAULT_SIZE), CGFloat(availableHeight) + CGFloat(DEFAULT_SIZE)),
        ]
        let shortestOffScreenLocation: (x: CGFloat, y: CGFloat) = locations.reduce((x: CGFloat(0), y: CGFloat(0))) { (currentShortestDistance, location) -> (x: CGFloat, y: CGFloat) in
            let currentXDistance = abs(x - currentShortestDistance.x)
            let currentYDistance = abs(y - currentShortestDistance.y)
            let newXDistance = abs(x - location.x)
            let newYDistance = abs(y - location.y)
            let currentTotalDistance = currentXDistance + currentYDistance
            let newTotalDistance = newXDistance + newYDistance
            if (currentTotalDistance < newTotalDistance) {
                return currentShortestDistance
            }
            return location
        }
        return shortestOffScreenLocation
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ToHighScoreScreenSegue") {
            
        }
    }
}
