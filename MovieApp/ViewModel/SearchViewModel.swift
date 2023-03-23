//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 23/03/2023.
//

import Foundation

protocol SearchViewModelDelegate {
    
    func shareData()
}


class SearchViewModel: SearchViewModelDelegate{
    
//    var items = Dynamic(TestAll(info: Info(count: Int(), pages: 0, next: "", prev: .none), results: []))
//    var sortedItems: [Result] = []
    
    var items = Dynamic(Movies(items: [], errorMessage: ""))
    var sortedMovies: [Item] = []
    
    private lazy var network: NetwrokService = {
        return Network()
    }()
    
    var title: String?
    var didChanged: Bool?
    
    func shareData(){
        network.getMovies { items in
            self.items.value = items
        }
    }
    
    func setTitle(title: String){
        self.title = title
        self.didChanged = true
        filterData()
    }
    
    func filterData(){
        self.sortedMovies = self.items.value.items.filter({$0.title.prefix(self.title?.count ?? 0) == self.title ?? ""})
    }
    
}
