//
//  Moves.swift
//  Pokedex
//
//  Created by Santiago on 9/18/17.
//  Copyright © 2017 Santiago. All rights reserved.
//

import Foundation
import Alamofire

class Moves {
    
    private var _moveName: String!
    private var _moveDesc: String!
    private var _power: String!
    private var _accuracy: String!
    private var _pp: String!
    var poke: Pokemon!
    
    
    var moveName: String {
        if _moveName == nil {
            _moveName = "Nothing"
        }
        return _moveName
    }
    
    var moveDesc: String {
        if _moveDesc == nil {
            _moveDesc = ""
        }
        return _moveDesc
    }
    
    var power: String {
        if _power == nil {
            _power = ""
        }
        return _power
    }
    
    var accuracy: String {
        if _accuracy == nil {
            _accuracy = ""
        }
        return _accuracy
    }
    
    var pp: String {
        if  _pp == nil {
            _pp = ""
        }
        return _pp
    }
    init(_movesDict: [Dictionary<String, AnyObject>]) {
                if let name = _movesDict[0]["name"] as? String {
                    self._moveName = name
        }
        
        if let moveurl = _movesDict[0]["resource_uri"] as? String {
            Alamofire.request("\(URL_BASE)\(moveurl)").responseJSON { response in
                let json = response.result.value
                
                if let dict = json as? Dictionary<String, AnyObject> {
                    
                    if let accuracy = dict["accuracy"] as? Int {
                        self._accuracy = "\(accuracy)"
                    }
                    
                    if let power = dict["power"] as? Int {
                        self._power = "\(power)"
                    }
                    
                    if let pp = dict["pp"] as? Int {
                        self._pp = "\(pp)"
                    }
                    
                    if let desc = dict["description"] as? String {
                       let updatedDesc = desc.replacingOccurrences(of: "\n\n", with: "")
                        self._moveDesc = "\(updatedDesc)"
                    }
                }
            }
        }
    }
    
}
        
