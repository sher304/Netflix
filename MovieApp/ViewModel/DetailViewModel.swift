//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 19/03/2023.
//

import Foundation


protocol DetailViewModelDelegate {
    func getId(id: String)
}

class DetailViewModel: DetailViewModelDelegate {
    
    var items = Dynamic(Movies(items: [], errorMessage: ""))
    
    var sortedItem = Dynamic(Item(id: "", rank: "", title: "", fullTitle: "", year: "", image: "", crew: "", imDBRating: "", imDBRatingCount: ""))
    
    var id: String? = nil
    
    func loadData(){
        APIAuth().getTopMovies { data in
            switch data {
            case.success(let data):
                for i in data.items {
                    if i.id == self.id{
                        self.items.value = data
                        print(i)
                        print(data)
                    }
                }
                break
            case.failure(_):
                break
            }
        }
    }
    
    func getId(id: String) {
        self.id = id
    }
}
