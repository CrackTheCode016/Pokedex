//
//  MoveCell.swift
//  Pokedex
//
//  Created by Santiago on 9/18/17.
//  Copyright © 2017 Santiago. All rights reserved.
//

import UIKit

class MoveCell: UITableViewCell {
    @IBOutlet weak var moveNameLabel: UILabel!
    @IBOutlet weak var moveDescLabel: UILabel!
    @IBOutlet weak var ppLabel: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var powerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func updateMoveCell(move: Moves) {
        moveNameLabel.text = move.moveName
        moveDescLabel.text = move.moveDesc
        ppLabel.text = move.pp
        powerLabel.text = move.power
        accuracyLabel.text = move.accuracy
        
        
    }

}
