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
    
    var items = Dynamic(TestAll(info: Info(count: Int(), pages: 0, next: "", prev: .none), results: []))
    
    private lazy var network: Network = {
        return Network()
    }()
    
    func shareData(){
        network.getAllTest { tests in
            self.items.value = tests
        }
    }
}
