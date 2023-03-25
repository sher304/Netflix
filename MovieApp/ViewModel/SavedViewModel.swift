//
//  SavedViewModel.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 25/03/2023.
//

import Foundation

protocol SavedViewModelDelegate {
    
    func loadView()
}


class SavedViewModel: SavedViewModelDelegate {
    
    var items = Dynamic(TestAll(info: Info(count: 0, pages: 0, next: "", prev: .none), results: []))
    
    private lazy var network: Network = {
        return Network()
    }()
    
    func loadView(){
        network.getAllTest { items in
            self.items.value = items
        }
    }
}
