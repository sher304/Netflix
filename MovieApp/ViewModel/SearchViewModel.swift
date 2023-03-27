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
    
    var items = Dynamic(TestAll(info: Info(count: Int(), pages: 0, next: "", prev: .none), results: []))
    var sortedItems: [ResultTest] = []
    
//    var items = Dynamic(Movies(items: [], errorMessage: ""))
//    var sortedMovies: [Item] = []
    
    private lazy var network: NetwrokService = {
        return Network()
    }()
    
    var title: String?
    func shareData(){
//        network.getMovies { items in
//            self.items.value = items
//        }
        network.getAllTest { test in
            self.items.value = test
        }
    }
    
    func setTitle(title: String){
        self.title = title
        filterData()
    }
    
    func filterData(){
        self.sortedItems = self.items.value.results.filter({$0.name.lowercased().prefix(self.title?.lowercased().count ?? 0) == self.title ?? ""})
    }
    
}
