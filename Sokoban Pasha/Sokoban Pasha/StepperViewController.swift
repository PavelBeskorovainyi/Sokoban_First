//
//  StepperViewController.swift
//  Sokoban Pasha
//
//  Created by Павел Бескоровайный on 13.01.2021.
//

import UIKit
import PKHUD

class StepperViewController: UIViewController {
    
    var delegate: SettingsDelegate?

    @IBOutlet weak var viewChangeCorners: UIView!
    @IBOutlet weak var buttonChangeCorners: UIButton!
    
    @IBOutlet var steppers: [UIStepper]!
    @IBOutlet var stepperLabels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewChangeCorners.layer.cornerRadius = 40
        self.buttonChangeCorners.layer.cornerRadius = 30
        self.stepperLabels[0].text = String(room.width)
        self.stepperLabels[1].text = String(room.height)
        self.steppers[0].value =
            Double(room.width)
        self.steppers[1].value =
            Double(room.height)
        
        addTapGestureToHideWindow ()
    }
    
    
    @IBAction func stepperTapped(_ sender: Any) {
        stepperLabels[0].text = String(Int(steppers[0].value))
        stepperLabels[1].text = String(Int(steppers[1].value))
    }
    
    @IBAction func setButton(_ sender: Any) {
        
        HUD.flash(.labeledProgress(title: "Size have changed", subtitle: "Positions of all objects become default"), onView: self.view, delay: 1.5) { (_) in
            self.view.removeFromSuperview()
        }
        
        room.width = Int(steppers[0].value)
        room.height = Int(steppers[1].value)
        
        game.endGame.positionX = room.width - 2
        game.endGame.positionY = room.height - 2
        game.startingPlayer.positionX = 1
        game.startingPlayer.positionY = 1
        game.startingBox.positionX = 2
        game.startingBox.positionY = 2
        game.player.positionX = game.startingPlayer.positionX
        game.player.positionY = game.startingPlayer.positionY
        game.box.positionX = game.startingBox.positionX
        game.box.positionY = game.startingBox.positionY
        
        delegate?.settingsChanged(gameField: field, moves: 0, counter: "New Game", description: "Width: \(room.width) Height: \(room.height)")
        
    }
    
    func addTapGestureToHideWindow () {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeWindow))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func closeWindow() {
        self.view.removeFromSuperview()
    }

}
