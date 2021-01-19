//
//  GameViewController.swift
//  Sokoban Pasha
//
//  Created by Павел Бескоровайный on 09.01.2021.
//

import UIKit

protocol SettingsDelegate {
    func settingsChanged (gameField: String, moves: Int, counter: String, description: String)
}


class GameViewController: UIViewController, SettingsDelegate {
 
    @IBOutlet weak var gameLabel: UITextView!
    
    @IBOutlet weak var gameText: UILabel!
    
    @IBOutlet weak var movesLabel: UILabel!
    
    
    private var countOfMoves = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gameLabel.text = field
        
    }
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromGameToSettings",
           let destination = segue.destination as? SettingsTableViewController {
            destination.delegate = self
        }
    }
    
    
    
    @IBAction func gameSteps(_ sender: UIButton) {
       

        self.gameText.text = "Good luck"
        self.movesLabel.text = "Moves: \(countOfMoves + 1)"
        
        countOfMoves += 1
    
        switch sender.tag {
       
        case 1: self.gameLabel.text = game.moveOn(go: .down)
            
            if game.player.positionY == room.height || game.player.positionX == game.box.positionX && game.box.positionY == room.height && game.player.positionY == game.box.positionY - 1{
                gameText.text = "You cant move down"
                countOfMoves -= 1 }
        case 2: self.gameLabel.text = game.moveOn(go: .up)
            if game.player.positionY == 1 || game.box.positionY == 1 && game.player.positionY == game.box.positionY + 1 && game.box.positionX == game.player.positionX {
                countOfMoves -= 1
                gameText.text = "You cant move up" }

        
        case 3: self.gameLabel.text = game.moveOn(go: .left)
            if game.player.positionX == 1 || game.box.positionX == 1 && game.player.positionX == game.box.positionX + 1 && game.player.positionY == game.box.positionY {
                countOfMoves -= 1
                gameText.text = "You cant move left" }
            

        case 4:
            self.gameLabel.text = game.moveOn(go: .right)
            if game.player.positionX == room.width || game.box.positionX == room.width &&
                game.player.positionX == game.box.positionX - 1 && game.player.positionY == game.box.positionY {
                countOfMoves -= 1
                gameText.text = "You cant move right" }

        default: break
        }
       
        
        if game.box.positionX == game.endGame.positionX && game.box.positionY == game.endGame.positionY {
           
            let alertController = UIAlertController(title: "Congratulations", message: "You win", preferredStyle: .alert)
            let action = UIAlertAction(title: "New Game", style: .default) { (action) in
                game.box.positionX = game.startingBox.positionX
                game.box.positionY = game.startingBox.positionY
                game.player.positionY = game.startingPlayer.positionY
                game.player.positionX = game.startingPlayer.positionX
                self.gameLabel.text = field
                self.countOfMoves = 0
                self.movesLabel.text = "You win"
                self.gameText.text = "Congratulations"
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func newGameButton(_ sender: UIButton) {
        countOfMoves = 0
        self.movesLabel.text = "Moves: \(countOfMoves)"
        game.player.positionX = game.startingPlayer.positionX
        game.box.positionX = game.startingBox.positionX
        game.player.positionY = game.startingPlayer.positionY
        game.box.positionY = game.startingBox.positionY
        gameLabel.text = field
        gameText.text = "New game is started"
    }
}

extension GameViewController {
    func settingsChanged (gameField: String, moves: Int, counter: String, description: String) {
        self.gameLabel.text = gameField
        self.movesLabel.text = counter
        self.gameText.text = description
        self.countOfMoves = moves
    }
}
