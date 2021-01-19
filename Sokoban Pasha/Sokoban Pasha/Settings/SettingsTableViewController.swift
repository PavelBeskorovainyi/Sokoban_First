//
//  SettingsTableViewController.swift
//  Sokoban Pasha
//
//  Created by Павел Бескоровайный on 09.01.2021.
//

import UIKit



class SettingsTableViewController: UITableViewController {
    
    var delegate: SettingsDelegate?
    
    private var cellIdentifier = "cellID"
    private var cellNames = [Cells]()
    
    public var changedIndexPath = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellNames.append(contentsOf: [
            Cells(cellName: "Player"),
            Cells(cellName: "Box"),
            Cells(cellName: "Hole"),
            //            Cells(cellName: "Size")
        ])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pickerID", let destination = segue.destination as? PickerViewController {
            destination.numberOfSelectedCell = self.changedIndexPath
            destination.delegate = self.delegate
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0: return self.cellNames.count
        case 1: return 1
        default: return 0
        }
        //        return self.cellNames.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SetTableViewCell
        switch indexPath.section {
        case 0: let object = cellNames[indexPath.row]
            cell?.setModelToUI(object)
            cell?.accessoryType = .disclosureIndicator
        case 1: let sizeObject = Cells(cellName: "Size")
            cell?.setModelToUI(sizeObject)
            cell?.accessoryType = .detailButton
        default: break
        }
        
        return cell ?? UITableViewCell()
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Positions of objects"
        default: return "Game Field"
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        changedIndexPath = indexPath.row
        
        
        if indexPath.section == 1 {
            let showUpWindow = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "stepperID") as! StepperViewController
            self.addChild(showUpWindow)
            showUpWindow.view.frame = self.view.frame
            self.view.addSubview(showUpWindow.view)
            showUpWindow.didMove(toParent: self)
            showUpWindow.delegate = self.delegate
            
        } else {
            self.performSegue(withIdentifier: "pickerID", sender: self) }
    }
}

