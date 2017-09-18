//
//  MovesVC.swift
//  Pokedex
//
//  Created by Santiago on 9/17/17.
//  Copyright © 2017 Santiago. All rights reserved.
//

import UIKit
import Alamofire

class MovesVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var poke: Pokemon!
    var movesArray = [Moves]()
    var move: Moves!
    var ifSearching = false
    var filteredMoveArray = [Moves]()
    @IBOutlet weak var tableMovesView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableMovesView.delegate = self
        tableMovesView.dataSource = self
        searchBar.delegate = self
        tableMovesView.reloadData()
        print(poke._pokemonURL!)
        
        downloadMove {
            self.tableMovesView.reloadData()
        }
   }
    
    
    
    
    func downloadMove( completed: @escaping DownloadComplete) {
        Alamofire.request(poke._pokemonURL).responseJSON { response in
            let json = response.result.value
            if let dict = json as? Dictionary<String, AnyObject> {
                if let moveDict = dict["moves"] as? [Dictionary<String, AnyObject>] {
                    for object in moveDict {
                         let move = Moves(_movesDict: [object])
                        if self.ifSearching == true {
                            self.filteredMoveArray.append(move)
                        }
                        else {
                            self.movesArray.append(move)

                        }
                    }
                }
            }
            completed()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ifSearching == true {
            return filteredMoveArray.count
        }
        else {
            return movesArray.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableMovesView.dequeueReusableCell(withIdentifier: "moveCell", for: indexPath) as? MoveCell {
             if ifSearching == true {
                cell.updateMoveCell(move: filteredMoveArray[indexPath.row])

            }
            
             else {
                cell.updateMoveCell(move: movesArray[indexPath.row])

            }
            return cell

        }
        
        else {
            return UITableViewCell()
        }

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" || searchBar.text == nil {
            ifSearching = false
            view.endEditing(true)
            tableMovesView.reloadData()
        }
        
        else {
            ifSearching = true
            let lower = searchBar.text!.lowercased().capitalized
            filteredMoveArray = movesArray.filter({$0.moveName.range(of: lower) != nil})
            tableMovesView.reloadData()
        }
    }
    
    
    


}
