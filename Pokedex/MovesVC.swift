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

    override func viewDidLoad() {
        super.viewDidLoad()
        
   }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movesSeg" {
            if let vc = segue.destination as? PokemonDetailVC {
                poke = vc.pokemon
            }
        }
    }


}
