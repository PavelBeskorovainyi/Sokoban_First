//
//  PickerViewController.swift
//  Sokoban Pasha
//
//  Created by Павел Бескоровайный on 09.01.2021.
//

import UIKit
import PKHUD



class PickerViewController: UIViewController {
    
    var delegate: SettingsDelegate?
    
    @IBOutlet weak var pickerOutlet: UIPickerView!
    
    
    private var numberFromPickerX: Int?
    private var numberFromPickerY: Int?
    
    public var numberOfSelectedCell: Int = 0

    
    override func viewDidLoad() {
        pickerOutlet.delegate = self
        pickerOutlet.dataSource = self
        super.viewDidLoad()
        
        switch numberOfSelectedCell {
        case 0: pickerOutlet.selectRow((game.startingPlayer.positionX - 1), inComponent: 0, animated: true)
            pickerOutlet.selectRow((game.startingPlayer.positionY - 1), inComponent: 1, animated: true)
        case 1: pickerOutlet.selectRow((game.startingBox.positionX - 1), inComponent: 0, animated: true)
            pickerOutlet.selectRow((game.startingBox.positionY - 1), inComponent: 1, animated: true)
        case 2: pickerOutlet.selectRow((game.endGame.positionX - 1), inComponent: 0, animated: true)
            pickerOutlet.selectRow((game.endGame.positionY - 1), inComponent: 1, animated: true)
        default: break
        }
        
    }
    
    
    
    @IBAction func setButton(_ sender: UIButton) {
        
        switch (numberFromPickerX, numberFromPickerY){
        
        case (nil, nil): self.dismiss(animated: true)
        
        case (_, nil):
            switch numberOfSelectedCell {
            case 0: game.startingPlayer.positionX = numberFromPickerX!
            case 1: game.startingBox.positionX = numberFromPickerX!
            case 2: game.endGame.positionX = numberFromPickerX!
            default: break
            }
        
        case (nil, _):
            switch numberOfSelectedCell {
            case 0: game.startingPlayer.positionY = numberFromPickerY!
            case 1: game.startingBox.positionY = numberFromPickerY!
            case 2: game.endGame.positionY = numberFromPickerY!
            default: break
            }
        
        default:
            switch numberOfSelectedCell {
            case 0:
                game.startingPlayer.positionX = numberFromPickerX!
                game.startingPlayer.positionY = numberFromPickerY!
            case 1:
                game.startingBox.positionX = numberFromPickerX!
                game.startingBox.positionY = numberFromPickerY!
            case 2:
                game.endGame.positionX = numberFromPickerX!
                game.endGame.positionY = numberFromPickerY!
                
            default: break
            }
        }
        
        
        if game.startingPlayer.positionX == game.startingBox.positionX &&  game.startingPlayer.positionY == game.startingBox.positionY || game.startingBox.positionX == game.endGame.positionX && game.startingBox.positionY == game.endGame.positionY || game.startingPlayer.positionX == game.endGame.positionX &&  game.startingPlayer.positionY == game.endGame.positionY {
            
            HUD.flash(.labeledError(title: "SAME POSITIONS", subtitle: "Choose new correct positions for all objects "), onView: self.view, delay: 2.3)
            {
                [weak game] (_) in
                guard let game = game else {return}
                
                game.startingBox.positionX = 2
                game.startingBox.positionY = 2
                game.startingPlayer.positionY = 1
                game.startingPlayer.positionX = 1
                game.endGame.positionX = room.width - 2
                game.endGame.positionY = room.height - 2
            }
                            
        } else if game.startingBox.positionX == 1 ||
                    game.startingBox.positionX == room.width ||
                    game.startingBox.positionY == room.height ||
                    game.startingBox.positionY == 1 {
            
            HUD.flash(.labeledError(title: "You never win", subtitle: "replace the box out of corners "), onView: self.view, delay: 2.3)
            {
                [weak game] (_) in
                guard let game = game else {return}
                game.startingBox.positionX = 2
                game.startingBox.positionY = 2
            }
           
        } else { self.dismiss(animated: true) }
        
        game.player.positionX = game.startingPlayer.positionX
        game.player.positionY = game.startingPlayer.positionY
        game.box.positionX = game.startingBox.positionX
        game.box.positionY = game.startingBox.positionY
        
        
        delegate?.settingsChanged(gameField: field, moves: 0, counter: "New Game", description: "You've set new positions")
    }
    
    
}

extension PickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return room.width
        case 1: return room.height
        default: return 0
        }
    }
}

extension PickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var array = [String]()
        
        switch component {
        
        case 0:
            for num in 1...room.width {
                array.append(String(num))
            }
            return array[row]
        case 1:
            for num in 1...room.height {
                array.append(String(num))
            }
            return array[row]
        
        default: return array[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0: numberFromPickerX = row + 1
        case 1: numberFromPickerY = row + 1
        default: break
        }
        
    }
    
}

