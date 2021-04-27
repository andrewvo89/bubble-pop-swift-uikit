//
//  File.swift
//  bubble-pop-swift-uikit
//
//  Created by Andrew Vo-Nguyen on 22/4/21.
//
import UIKit

class Score {
    var name: String
    var score: Int
    
    init(name: String, score: Int) {
        self.name = name
        self.score = score
    }
    
    
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
    
    func register() -> Void {
        let userDefaults = UserDefaults.standard
        var scoresDictionary = userDefaults.object(forKey: "highScores") as? Dictionary<String, Int> ?? Dictionary<String, Int>()
        let currentHighScore: Int = scoresDictionary[name] ?? 0
        userDefaults.removeObject(forKey: "")
        userDefaults.setValue(nil, forKey: "")
        if (score > currentHighScore) {
            scoresDictionary[name] = score
            userDefaults.setValue(scoresDictionary, forKey: "highScores")
        }
    }
}
