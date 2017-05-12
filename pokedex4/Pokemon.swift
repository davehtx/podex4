//
//  Pokemon.swift
//  pokedex4
//
//  Created by Dave Hofmann on 4/26/17.
//  Copyright © 2017 DaveApps. All rights reserved.
//

import Foundation

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokedexID: Int!
    
    var name: String {
        
        return _name
    }

    var pokedexID: Int {
        
        return _pokedexID
    }
    
    init(name: String, pokedexID: Int) {
        self._name = name
        self._pokedexID = pokedexID
        
        
    }
}
