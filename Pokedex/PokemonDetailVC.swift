//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Santiago on 9/9/17.
//  Copyright © 2017 Santiago. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!

    @IBOutlet weak var mainPokeImage: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var pokedexIDLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var currentPoke: UIImageView!
    @IBOutlet weak var nextEvo: UIImageView!
    @IBOutlet weak var evoLabel: UILabel!
    @IBOutlet weak var mainTopLabel: UILabel!
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        
        mainPokeImage.image = img
        currentPoke.image = img
        pokemon.downloadPokemonDetails {
            self.updateUI()
        }

    }
    
    func updateUI() {
        
        attackLabel.text = pokemon.attack
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        mainTopLabel.text = pokemon.name.capitalized
        typeLabel.text = pokemon.type
        descLabel.text = pokemon.desc
        pokedexIDLabel.text = "\(pokemon.pokedexId)"
        
        if pokemon.nextEvoId == "" {
            evoLabel.text = "No Evolutions"
            nextEvo.isHidden = true
        }
        
        else {
            nextEvo.isHidden = false
            nextEvo.image = UIImage(named: pokemon.nextEvoId)
            let evotxt = "Next Evolution: \(pokemon.nextEvoName), Level \(pokemon.nextEvoLevel)"
            evoLabel.text = evotxt

        }
        
        
    }
    
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
}
