//
//  SetTableViewCell.swift
//  Sokoban Pasha
//
//  Created by Павел Бескоровайный on 09.01.2021.
//

import UIKit

class SetTableViewCell: UITableViewCell {

 
    @IBOutlet weak var cellLabel: UILabel!
    
    public func setModelToUI(_ model: Cells?) {
        cellLabel.text = model?.cellName ?? ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
