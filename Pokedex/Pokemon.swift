
import Foundation
import Alamofire


class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _desc: String!
    private var _defense: String!
    private var _weight: String!
    private var _attack: String!
    private var _height: String!
    private var _nextEvo: String!
    private var _nextEvoName: String!
    private var _nextEvoId: String!
    private var _nextEvoLevel: String!
    private var _type: String!
    private var _pokemonURL: String!
    
    var nextEvoName: String {
        if _nextEvoName == nil  {
            _nextEvoName = ""
        }
        return _nextEvoName
    }
    
    var nextEvoId: String {
        if _nextEvoId == nil  {
            _nextEvoId = ""
        }
        return _nextEvoId
    }
    
    var nextEvoLevel: String {
        if _nextEvoLevel == nil  {
            _nextEvoLevel = ""
        }
        return _nextEvoLevel
    }

    
    var desc: String {
        if _desc == nil  {
            _desc = ""
        }
        return _desc
    }
    
    var defense: String {
        if _defense == nil  {
            _defense = ""
        }
        return _defense
    }
    
    var weight: String {
        if _weight == nil  {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil  {
            _attack = ""
        }
        return _attack
    }
    
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var nextEvo: String {
        if _nextEvo == nil {
            _nextEvo = ""
        }
        return _nextEvo
    }
    
    
    var type: String {
    if _type == nil {
    _type = ""
    }
    return  _type
    
    }

    
    var name: String {
        return _name
    }
    
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        Alamofire.request(_pokemonURL).responseJSON { response in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
            
                if let weight = dict["weight"] as? String {
                self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                print(self._weight, self._attack, self._defense, self._height)
                
                if let typeDict = dict["types"] as? [Dictionary<String, AnyObject>], typeDict.count > 0 {
                    
                    
                    for item in 0..<typeDict.count {
                    
                        if item == 0 {
                             self._type = typeDict[item]["name"]?.capitalized!
                        }
                        
                        else {
                            self._type! += "/\((typeDict[item]["name"]?.capitalized)!)"
                        }
                        
                    }
                    
                    if let descArr = dict["descriptions"] as? [Dictionary<String, String>], descArr.count > 0 {
                        
                        if let url = descArr[0]["resource_uri"] {
                            let descURL = "\(URL_BASE)\(url)"
                            Alamofire.request(descURL).responseJSON(completionHandler: { response in
                                if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                    if let desc = descDict["description"] as? String {
                                        let newDesc = desc.replacingOccurrences(of: "POKMON", with: "POKEMON")
                                        self._desc = newDesc
                                        
                                    }
                                }
                                completed()

                            })
                        }
                    }
                    
                    if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0 {
                        
                        if let nextEvo = evolutions[0]["to"] as? String {
                            if nextEvo.range(of: "mega") == nil {
                                self._nextEvoName = nextEvo
                                
                                if let uri = evolutions[0]["resource_uri"] as? String {
                                    let newId = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                    let finalId = newId.replacingOccurrences(of: "/", with: "")
                                    
                                    self._nextEvoId = finalId
                                    
                                    if let lvlExists = evolutions[0]["level"] {
                                        if let lvl = lvlExists as? Int {
                                            self._nextEvoLevel = "\(lvl)"
                                        }
                                    }
                                    
                                    else {
                                        self._nextEvoLevel = ""
                                    }
                                }
                            }
                            
                        }
                    }
                    
                }
                    
                    
                
            }
            completed()

        }
    }

    
}
    

