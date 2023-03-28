//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 19/03/2023.
//

import Foundation


protocol DetailViewModelDelegate {
    func loadData()
    func getId(id: String)
    func saveId(id: String)
    func delete(id: String)
}

class DetailViewModel: DetailViewModelDelegate{
    
    static let shared = DetailViewModel()
    //MARK: Network Connection
    private lazy var network: Network = {
        return Network()
    }()
    
    //MARK: Set id of Movie
    var id: String?
    
    //MARK: Get Id of Movie
    func getId(id: String) {
        self.id = id
    }
    
    //MARK: Data Movie
    var dataMovie =  Dynamic(DetailModel(imDBID: "", title: "", fullTitle: "", type: "", year: "", items: [], errorMessage: ""))
    
    //MARK: Load Data
    func loadData(){
        APIAuth().getTopMovies(id: id ?? "!") { data in
            switch data{
            case.success(let data):
                self.dataMovie.value = data
                break
            case.failure(_):
                print("errorrrerer")
                break
            }
        }
    }
    
    //MARK: Data of Ids
    var dataId: [String] = []
    
    //MARK: UserDefaults
    let defautls = UserDefaults.standard
    
    //MARK: Save Id of Movie
    func saveId(id: String){
        dataId.append(id)
        defautls.set(dataId, forKey: "MovieIds")
    }
    
    //MARK: Delete Movie from DB
    func delete(id: String){
        let filtredData = dataId.filter {$0 != id }
        self.dataId = filtredData
        defautls.set(dataId, forKey: "MovieIds")
    }
    
}
