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
    
    func shareData(){
        APIAuth().getTopMovies { [self] data in
            switch data {
            case .success(let data):
                items.value = data
                print(data)
            case .failure(_):
                break
            }
        }
    }
    
}
