//
//  ViewController.swift
//  pokedex4
//
//  Created by Dave Hofmann on 4/25/17.
//  Copyright © 2017 DaveApps. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    
    @IBOutlet weak var collection: UICollectionView!
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Inside viewdidload")
        
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        
        // parse as soon as we start app
        
        parsePokemonCSV()
        initAudio()
        
    }
    
    func initAudio () {
        
        let path = Bundle.main.path(forResource: "music2", ofType: "mp3")
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path!)!)
            
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
            
            
        } catch let err as NSError {
            
            print(err.debugDescription)
            
        }
    }
    
    
    func parsePokemonCSV() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfUrl: path)
            let rows = csv.rows
            print(rows)
            // get pokeID and name
            
            for row in rows {
                
                let pokeID = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokedexID: pokeID)
                pokemon.append(poke)
                
                
            }
            
     
        } catch let err as NSError {
            print(err.debugDescription)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Inside numberOfItemsInSection")
        return pokemon.count
        
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("Inside cellForItemAt")
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            print("After dequeueReusableCell")
            
            //  let pokemon = Pokemon(name: "Pokemon", pokedexID: indexPath.row)
            let poke = pokemon[indexPath.row]
            
            cell.configureCell(poke)
            
    
            return cell
        }
            
        else { print("After ELSE dequeueReusableCell")
            return UICollectionViewCell()

    }
        }
    
    
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            print("Inside numberOfSections")
        }
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("Inside didSelectItemAt")
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        print("Inside CGSize")

        
        return CGSize(width: 105, height: 105)
        
    }
    
    

    @IBAction func musicBtnPressed(_ sender: UIButton) {
        
        if musicPlayer.isPlaying {
            
            musicPlayer.pause()
            sender.alpha = 0.2
        } else {
            
            musicPlayer.play()
            sender.alpha = 1.0
            
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("typing")
        
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
        } else {
            
            inSearchMode = true
            
            
        }
        
    }
}

