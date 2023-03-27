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
    
    var movieData = Dynamic(TestAll(info: Info(count: 0, pages: 0, next: "", prev: .none), results: []))
    
    var filtredData = Dynamic([ResultTest]())
    
    private lazy var network: Network = {
        return Network()
    }()
    
    private var detailViewModel = DetailViewModel.shared
    
    func sortItems(data: TestAll){
        let dataBase = detailViewModel.defautls.array(forKey: "MovieIds") as? [String]
        for i in data.results{
            if dataBase?.contains(i.id.description) ?? false{
                var filtredData = filtredData.value
                filtredData.append(i)
                self.filtredData.value = filtredData
            }
        }
    }
    
    func loadView(){
        network.getAllTest { data in
            self.movieData.value = data
            self.sortItems(data: data)
        }
    }
}
