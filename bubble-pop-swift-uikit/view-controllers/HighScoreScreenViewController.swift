//
//  HighScoreScreenViewController.swift
//  bubble-pop-swift-uikit
//
//  Created by Andrew Vo-Nguyen on 23/4/21.
//

import UIKit

class HighScoreScreenViewController: UIViewController {
    @IBOutlet weak var MainCard: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
//        let defaults = UserDefaults.standard
//            let dictionary = defaults.dictionaryRepresentation()
//        for key in dictionary.keys {
//            print(key)
//            
//        }
//            dictionary.keys.forEach { key in
//                defaults.removeObject(forKey: key)
//            }
//        print(Array(UserDefaults.standard.dictionaryRepresentation().keys))

    }
    
    func initializeUI() {
        //Set card styles for game options card
        MainCard.layer.borderWidth = 1
        MainCard.layer.borderColor = UIColor.black.cgColor
        MainCard.layer.cornerRadius = 8
        MainCard.layer.shadowColor = UIColor.black.cgColor
        MainCard.layer.shadowOpacity = 0.6
        MainCard.layer.shadowOffset = .init(width: 3, height: 3)
        MainCard.layer.shadowRadius = 3
    }
}
