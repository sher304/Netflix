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
    func retrive()
    func delete(id: String)
}

class DetailViewModel: DetailViewModelDelegate{
    
    static let shared = DetailViewModel()
    
    //        var itemMovie = Dynamic(SearchModel(id: "", title: "", originalTitle: "", fullTitle: "", type: "", year: "", image: "", releaseDate: "", runtimeMins: "", runtimeStr: "", plot: "", plotLocal: "", plotLocalIsRTL: Bool(), awards: "", directors: "", directorList: [], writers: "", writerList: [], stars: "", starList: [], actorList: [], fullCast: .none, genres: "", genreList: [], companies: "", companyList: [], countries: "", countryList: [], languages: "", languageList: [], contentRating: "", imDBRating: "", imDBRatingVotes: "", metacriticRating: "", ratings: .none, wikipedia: .none, posters: .none, images: .none, trailer: .none, boxOffice: BoxOffice(budget: "", openingWeekendUSA: "", grossUSA: "", cumulativeWorldwideGross: ""), tagline: .none, keywords: "", keywordList: [], similars: [], tvSeriesInfo: .none, tvEpisodeInfo: .none, errorMessage: ""))
    
    //    var itemMovie = Dynamic(SearchModel(imDBID: "", title: "", fullTitle: "", type: "", year: "", directors: Directors(job: "", items: []), writers: Directors(job: "", items: []), actors: [], others: [], errorMessage: ""))
    
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
    //    var dataMovie = Dynamic(SingleTest(id: 0, name: "", status: "", species: "", type: "", gender: "", origin: LocationSingle(name: "", url: ""), location: LocationSingle(name: "", url: ""), image: "", episode: [], url: "", created: ""))
    
//    var dataMovie =  Dynamic(DetailModel(imDBID: "", title: "", fullTitle: "", type: "", year: "", directors: Directors(job: "", items: []), writers: Directors(job: "", items: []), actors: [], others: [], errorMessage: ""))
    
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
    var data: [String] = []
    
    //MARK: UserDefaults
    let defautls = UserDefaults.standard
    
    //MARK: Save Id of Movie
    func saveId(id: String){
        data.append(id)
        defautls.set(data, forKey: "MovieIds")
    }
    
    //MARK: Show  movie, from DB
    func retrive(){
        print(defautls.array(forKey: "MovieIds"))
    }
    
    //MARK: Delete Movie from DB
    func delete(id: String){
        let filtredData = data.filter {$0 != id }
        self.data = filtredData
        defautls.set(data, forKey: "MovieIds")
    }
    
}
