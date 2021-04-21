//
//  File.swift
//  bubble-pop-swift-uikit
//
//  Created by Andrew Vo-Nguyen on 22/4/21.
//
import UIKit

class Score: NSObject {
    var name: String
    var score: Int
    var gameDuration: Int
    var date: Date
    
    init(name: String, score: Int, gameDuration: Int, date: Date) {
        self.name = name
        self.score = score
        self.gameDuration = gameDuration
        self.date = date
    }
}
