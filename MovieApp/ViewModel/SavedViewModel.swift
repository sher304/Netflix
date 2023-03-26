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
    
    private var detailViewModel = DetailViewModel.shared
    
    
    func sortItems(data: TestAll){
        let dataB = detailViewModel.defautls.array(forKey: "MovieIds") as? [String]
        dataB?.forEach({ id in
            let dublicate = data.results.filter({$0.id.description == id})
            self.items.value.results = dublicate
        })
    }
    
    
    func loadView(){
        network.getAllTest { items in
            self.sortItems(data: items)
        }
    }
}
