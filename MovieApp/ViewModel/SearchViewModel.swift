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
    var sortedItems: [Result] = []
    
    private lazy var network: NetwrokService = {
        return Network()
    }()
    
    var title: String?
    var didChanged: Bool?
    
    func shareData(){
        network.getAllTest { items in
            self.items.value = items
        }
    }
    
    func setTitle(title: String){
        self.title = title
        self.didChanged = true
        filterData()
    }
    
    func filterData(){
        self.sortedItems = self.items.value.results.filter({$0.name.prefix(self.title?.count ?? 0) == self.title ?? ""})
    }
    
}
