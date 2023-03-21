//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 19/03/2023.
//

import Foundation

protocol HomeViewModelDelegate {
    func shareData()
    
}

class HomeViewModel: HomeViewModelDelegate {
    
    var items = Dynamic(Movies(items: [], errorMessage: String()))
    
    private lazy var network: Network = {
        return Network()
    }()
    
    func shareData(){
        network.getMovies { movies in
            self.items.value = movies
        }
    }
    
}
