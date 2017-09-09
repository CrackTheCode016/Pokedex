//
//  ViewController.swift
//  Pokedex
//
//  Created by Santiago on 9/9/17.
//  Copyright © 2017 Santiago. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var pokeArray = [Pokemon]()
    var filteredPokeArray = [Pokemon]()
    var ifSearch = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokemonCSV()
        initAudio()
        
    }
    
    func initAudio() {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")
        do {
            
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path!)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        }
        
        catch let err as NSError {
            print(err.debugDescription)
            
        }
    }
    
    @IBAction func musicPlayBtnPress(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.2
        }
        
        else {
            musicPlayer.play()
            sender.alpha = 1.0

        }
        
    }
    func parsePokemonCSV() {
    
    
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        do {
            
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            print(rows)
            
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                let pokemonLoopItem = Pokemon(name: name, pokedexId: pokeId)
                pokeArray.append(pokemonLoopItem)
        }
    }
        
        catch let err as NSError {
            print(err.debugDescription)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            let pokemon: Pokemon!
            
            if ifSearch == true {
                pokemon = filteredPokeArray[indexPath.row]
                cell.updateCell(pokemon)
            }
            
            else {
                pokemon = pokeArray[indexPath.row]
                cell.updateCell(pokemon)
            }
            
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if ifSearch == true {
            return filteredPokeArray.count
        }
        else {
            return pokeArray.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: 105, height: 105)
        }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            ifSearch = false
            collectionView.reloadData()
            view.endEditing(true)
        }
        
        else {
            ifSearch = true
            
            let lower = searchBar.text!.lowercased()
            
            filteredPokeArray = pokeArray.filter({$0.name.range(of: lower) != nil})
            collectionView.reloadData()
        }
    }
}

