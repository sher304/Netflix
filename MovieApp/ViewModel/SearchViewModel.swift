//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 23/03/2023.
//

import Foundation

protocol SearchViewModelDelegate {
    func shareData()
    func setTitle(title: String)
    func filterData()
}


class SearchViewModel: SearchViewModelDelegate{
    
    var movieData = Dynamic(Movies(items: [], errorMessage: ""))
    var sortedMovies: [Item] = []
    
    //MARK: Connect with network
    private lazy var network: NetwrokService = {
        return Network()
    }()
    
    //MARK: Title of search
    var title: String?
    
    //MARK: ShareData
    func shareData(){
        APIAuth().getTopMovies { movieData in
            switch movieData{
            case.success(let movieData):
                self.movieData.value = movieData
                break
            case.failure(_):
                break
            }
        }
    }
    
    //MARK: Set title, of search
    func setTitle(title: String){
        self.title = title
        filterData()
    }
    
    //MARK: Filter Data of search
    func filterData(){
        self.sortedMovies = self.movieData.value.items.filter({$0.title.lowercased().prefix(self.title?.lowercased().count ?? 0) == self.title ?? ""})
    }
}
