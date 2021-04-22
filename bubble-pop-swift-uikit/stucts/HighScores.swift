//
//  HighScores.swift
//  bubble-pop-swift-uikit
//
//  Created by Andrew Vo-Nguyen on 23/4/21.
//

import UIKit

struct HighScores {
    static func getAll() -> [Score] {
        let userDefaults = UserDefaults.standard
        let scoresDictionary = userDefaults.object(forKey: "highScores") as? Dictionary<String, Int> ?? Dictionary<String, Int>()
        var scores: [Score] = []
        for (key, value) in scoresDictionary {
            scores.append(Score(name: key, score: value))
        }
        let scoreSorted = scores.sorted { (scoreA, scoreB) -> Bool in
            scoreA.score > scoreB.score
        }
        return scoreSorted
    }
    
    func register(score: Score) -> Void {
        let userDefaults = UserDefaults.standard
        var scoresDictionary = userDefaults.object(forKey: "highScores") as? Dictionary<String, Int> ?? Dictionary<String, Int>()
        let currentHighScore: Int = scoresDictionary[score.name] ?? 0
        
        if (score.score > currentHighScore) {
            scoresDictionary[score.name] = score.score
            userDefaults.setValue(scoresDictionary, forKey: "highScores")
        }
    }
    
}
