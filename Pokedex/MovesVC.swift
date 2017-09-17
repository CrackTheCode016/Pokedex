//
//  MovesVC.swift
//  Pokedex
//
//  Created by Santiago on 9/17/17.
//  Copyright © 2017 Santiago. All rights reserved.
//

import UIKit

class MovesVC: UIViewController {
    
    var poke: Pokemon!
    @IBOutlet weak var mainMovesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if poke.name == "" {
            print("The name is nil")
        }
        
        else {
            mainMovesLabel.text = "\(poke.name.capitalized)'s Moves"
            print(poke.name)
        }
   }


}
