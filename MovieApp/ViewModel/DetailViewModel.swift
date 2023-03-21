//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 19/03/2023.
//

import Foundation


protocol DetailViewModelDelegate {
    func getId(id: String)
    func loadData()
}

class DetailViewModel: DetailViewModelDelegate {
    
    //    var itemMovie = Dynamic(Movie(id: "", title: "", originalTitle: "", fullTitle: "", type: "", year: "", image: "", releaseDate: "", runtimeMins: "", runtimeStr: "", plot: "", plotLocal: "", plotLocalIsRTL: Bool(), awards: "", directors: "", directorList: [], writers: "", writerList: [], stars: "", starList: [], actorList: [], fullCast: .none, genres: "", genreList: [], companies: "", companyList: [], countries: "", countryList: [], languages: "", languageList: [], contentRating: "", imDBRating: "", imDBRatingVotes: "", metacriticRating: "", ratings: .none, wikipedia: .none, posters: .none, images: .none, trailer: .none, boxOffice: BoxOffice(budget: "", openingWeekendUSA: "", grossUSA: "", cumulativeWorldwideGross: ""), tagline: .none, keywords: "", keywordList: [], similars: [], tvSeriesInfo: .none, tvEpisodeInfo: .none, errorMessage: ""))
    
    private lazy var network: Network = {
        return Network()
    }()
    
    var id: String?
    
    func getId(id: String) {
        self.id = id
        print(id)
    }
    
    //    func loadData(){
    //        network.getMovie(id: id ?? "tt0110413") { movie in
    //            print(self.id ?? "")
    //            self.itemMovie.value = movie
    //        }
    //    }
    
    var items = Dynamic(SingleTest(id: 0, name: "", status: "", species: "", type: "", gender: "", origin: LocationSingle(name: "", url: ""), location: LocationSingle(name: "", url: ""), image: "", episode: [], url: "", created: ""))

    
    func loadData(){
        print(id)
        network.getCharacter(id: id ?? "3") { single in
            print(self.id)
            self.items.value = single
        }
    }
    
}
