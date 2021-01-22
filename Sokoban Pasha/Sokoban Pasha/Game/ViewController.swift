//
//  ViewController.swift
//  Sokoban Pasha
//
//  Created by Павел Бескоровайный on 08.01.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var mainMenuButtons: [UIButton]!
    
    @IBAction func newGameFromMenu(_ sender: Any) {
        game.player.positionX = game.startingPlayer.positionX
        game.box.positionX = game.startingBox.positionX
        game.player.positionY = game.startingPlayer.positionY
        game.box.positionY = game.startingBox.positionY
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.mainMenuButtons.forEach({$0.layer.cornerRadius = 25})
    }


}

