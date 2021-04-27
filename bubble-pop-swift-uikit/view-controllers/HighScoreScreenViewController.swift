//
//  HighScoreScreenViewController.swift
//  bubble-pop-swift-uikit
//
//  Created by Andrew Vo-Nguyen on 23/4/21.
//

import UIKit

class HighScoreScreenViewController: UIViewController {
   
    @IBOutlet weak var MainCard: UIView!
    
    @IBOutlet weak var HighScoreTableView: UITableView!
    @IBOutlet weak var PlayAgainButton: UIButton!
    @IBOutlet weak var ScoreTitleLabel: UILabel!
    
    var highScores: [Score] = []
    var score: Int = 0
    
    override func viewDidLoad() {
        highScores = Score.getAll()
        super.viewDidLoad()
        
        let nib = UINib(nibName: "HighScoreTableViewCell", bundle: nil)
        HighScoreTableView.register(nib, forCellReuseIdentifier: "HighScoreTableViewCell")
        HighScoreTableView.delegate = self
        HighScoreTableView.dataSource = self
        
        initializeUI()
    }
    
    
    func initializeUI() {
        //Game Label
        ScoreTitleLabel.font = UIFont.systemFont(ofSize: 24)
        
        //Set card styles for game options card
        MainCard.layer.borderWidth = 1
        MainCard.layer.borderColor = UIColor.black.cgColor
        MainCard.layer.cornerRadius = 8
        MainCard.layer.shadowColor = UIColor.black.cgColor
        MainCard.layer.shadowOpacity = 0.3
        MainCard.layer.shadowOffset = .init(width: 3, height: 3)
        MainCard.layer.shadowRadius = 3
        
        
        //Start game button
        PlayAgainButton.setTitle("Play Again", for: UIControl.State.normal)
        PlayAgainButton.layer.cornerRadius = 8
        PlayAgainButton.layer.borderWidth = 1
        PlayAgainButton.layer.borderColor = UIColor.black.cgColor
        PlayAgainButton.contentEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        PlayAgainButton.titleLabel?.font = UIFont(name: "System", size: 16.0)
        
        //Display score from Segue
        ScoreTitleLabel.text = "Your Score: \(score)"
    }
}

//Extension protocol functions
extension HighScoreScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("The row was tapped")
    }
}

extension HighScoreScreenViewController: UITableViewDataSource {
    //Set amount of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        highScores.count
    }
    
    //Set values of custom cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HighScoreTableView.dequeueReusableCell(withIdentifier: "HighScoreTableViewCell", for: indexPath) as! HighScoreTableViewCell
        cell.NameLabel?.text = highScores[indexPath.row].name
        cell.ScoreLabel?.text = String(highScores[indexPath.row].score)
        return cell
    }
}
