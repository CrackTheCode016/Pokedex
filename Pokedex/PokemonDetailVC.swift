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
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var Segment: UISegmentedControl!
    @IBOutlet weak var containerMovesView: UIView!
    var movesVC: MovesVC!

    
    override func viewDidLoad() {
        super.viewDidLoad()
       let img = UIImage(named: "\(pokemon.pokedexId)")
       mainPokeImage.image = img
       currentPoke.image = img
        poke = pokemon
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
            evoLabel.text = "Next Evolution: \(pokemon.nextEvoName), Level \(pokemon.nextEvoLevel)"

        }
    }
    
    @IBAction func bioMovesControl(_ sender: Any) {
        if Segment.selectedSegmentIndex == 0 {
            mainStackView.isHidden = false
            containerMovesView.isHidden = true
            
        }
        
        if Segment.selectedSegmentIndex == 1 {
            mainStackView.isHidden = true
            poke = pokemon
            containerMovesView.isHidden = false

        }
        
        
    }    
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MovesVC", let vc = segue.destination as? MovesVC {
            vc.poke = pokemon
        }
    }
    
}
