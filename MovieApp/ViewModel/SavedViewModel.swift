//
//  SavedViewModel.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 25/03/2023.
//

import Foundation

protocol SavedViewModelDelegate {
    func loadView()
//    func sortItems(data: TestAll)
    func sortItems(data: Movies)
    
}


class SavedViewModel: SavedViewModelDelegate {
    
    static let shared = SavedViewModel()
    
    //MARK: Unsorted Movie Data
    var movieData = Dynamic(Movies(items: [], errorMessage: ""))
    
    //MARK: Filtred Data
    var filtredData = Dynamic([Item]())
    
    //MARK: Connection With Network
    private lazy var network: Network = {
        return Network()
    }()
    
    //MARK: Connection Detail View Model
    private var detailViewModel = DetailViewModel.shared
    
    //MARK: Sort Saved Data
    func sortItems(data: Movies){
        let dataBase = detailViewModel.defautls.array(forKey: "MovieIds") as? [String]
        for i in data.items{
            if dataBase?.contains(i.id.description) ?? false{
                var filtredData = filtredData.value
                filtredData.append(i)
                self.filtredData.value = filtredData
            }
        }
    }
    
    //MARK: Load View
    func loadView(){
//        APIAuth().getTopMovies { dataMovie in
//            switch dataMovie{
//            case.success(let successData):
//                self.movieData.value = successData
//                self.sortItems(data: successData)
//                break
//            case.failure(_):
//                break
//            }
//        }
        sortItems(data: movieData.value)
    }
}
