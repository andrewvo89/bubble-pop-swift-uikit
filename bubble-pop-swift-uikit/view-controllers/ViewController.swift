//
//  ViewController.swift
//  bubble-pop-swift-uikit
//
//  Created by Andrew Vo-Nguyen on 17/4/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var name:String = "" {
        didSet {
            StartGameButton.isEnabled = name.count > 0
        }
    }

    var gameDuration:Int = 60 {
        didSet {
            GameDurationLabel.text = "Game Duration: \(String(gameDuration)) seconds"
        }
    }

    var maxBubbles:Int = 15 {
        didSet {
            MaxBubblesLabel.text = "Maximum Bubbles: \(String(maxBubbles))"
        }
    }

    @IBOutlet weak var GameTitleLabel: UILabel!
    @IBOutlet weak var SettingsCard: UIView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var GameDurationLabel: UILabel!
    @IBOutlet weak var GameDurationSlider: UISlider!
    @IBOutlet weak var MaxBubblesLabel: UILabel!
    @IBOutlet weak var MaxBubblesSlider: UISlider!
    @IBOutlet weak var StartGameButton: UIButton!
    
    @IBAction func onNameTextFieldEditingChanged(_ sender: UITextField) {
        name = NameTextField.text ?? ""
    }
    
    @IBAction func onGameDurationSliderValueChanged(_ sender: UISlider) {
        gameDuration = Int(GameDurationSlider.value)
    }
    
    @IBAction func onMaxBubblesSliderValueChanged(_ sender: UISlider) {
        maxBubbles = Int(MaxBubblesSlider.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialize()
        //Add NameTextField delegate protocol
        self.NameTextField.delegate = self
        //Register a tapper to handle dismissing keyboard when tapping outside of TextField
        let tapper = UITapGestureRecognizer(target: self, action:#selector(dismissKeyboard))
        tapper.cancelsTouchesInView = false
        view.addGestureRecognizer(tapper)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Function to close keyboard after pressing return
        dismissKeyboard()
        return false
    }
    
    @objc func dismissKeyboard() -> Void {
        self.view.endEditing(true)
    }
    
    func initialize() -> Void {
        //Game Label
        GameTitleLabel.font = UIFont.systemFont(ofSize: 24)
        GameTitleLabel.text = "Bubble Pop!"
        
        //Name
        name = ""
        NameLabel.text = "Your Name:"
        NameTextField.text = name
        
        //Game Duration
        gameDuration = 60
        GameDurationSlider.minimumValue = 10
        GameDurationSlider.maximumValue = 120
        GameDurationSlider.value = Float(gameDuration)
        
        //Max Bubbles
        maxBubbles = 15
        MaxBubblesSlider.minimumValue = 1
        MaxBubblesSlider.maximumValue = 30
        MaxBubblesSlider.value = Float(maxBubbles)
        
        //Start game button
        StartGameButton.setTitle("Start Game", for: UIControl.State.normal)
        StartGameButton.layer.cornerRadius = 8
        StartGameButton.layer.borderWidth = 1
        StartGameButton.layer.borderColor = UIColor.black.cgColor
        StartGameButton.contentEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        StartGameButton.titleLabel?.font = UIFont(name: "System", size: 16.0)
        
        //Set card styles for game options card
        SettingsCard.layer.borderWidth = 1
        SettingsCard.layer.borderColor = UIColor.black.cgColor
        SettingsCard.layer.cornerRadius = 8
        SettingsCard.layer.shadowColor = UIColor.black.cgColor
        SettingsCard.layer.shadowOpacity = 0.3
        SettingsCard.layer.shadowOffset = .init(width: 3, height: 3)
        SettingsCard.layer.shadowRadius = 3
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ToCountdownScreenSegue") {
            let viewController = segue.destination as! CountdownScreenViewController
            viewController.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
            viewController.gameDuration = gameDuration
            viewController.maxBubbles = maxBubbles
        }
    }
}

