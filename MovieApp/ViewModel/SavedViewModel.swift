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
    
    static let shared = SavedViewModel()
    
    var items = Dynamic(TestAll(info: Info(count: 0, pages: 0, next: "", prev: .none), results: []))
    
    var filtredData = Dynamic([ResultTest]())
    
    private lazy var network: Network = {
        return Network()
    }()
    
    private var detailViewModel = DetailViewModel.shared
    
    func sortItems(data: TestAll){
        let dataB = detailViewModel.defautls.array(forKey: "MovieIds") as? [String]
        for i in data.results{
            if dataB?.contains(i.id.description) ?? false{
                var fildata = filtredData.value
                fildata.append(i)
                self.filtredData.value = fildata
            }
        }
    }
    
    func loadView(){
        network.getAllTest { items in
            self.items.value = items
            self.sortItems(data: items)
        }
    }
}
