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
    var movies = Dynamic(Movies(items: [], errorMessage: ""))
    
    //MARK: Connect with Network
    private lazy var network: Network = {
        return Network()
    }()
    
    //MARK: Load Data from Network
    func shareData(){
        APIAuth().getTopMovies { movieData in
            switch movieData{
            case.success(let data):
                self.movies.value = data
                break
            case.failure(_):
                break
            }
        }
    }
}
