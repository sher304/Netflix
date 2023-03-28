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
    
//    var items = Dynamic(TestAll(info: Info(count: Int(), pages: 0, next: "", prev: .none), results: []))
    
//    var items = Dynamic(Movie(id: "", title: "", originalTitle: "", fullTitle: "", type: "", year: "", image: "", releaseDate: "", runtimeMins: "", runtimeStr: "", plot: "", plotLocal: "", plotLocalIsRTL: Bool(), awards: "", directors: "", directorList: [], writers: "", writerList: [], stars: "", starList: [], actorList: [], fullCast: .none, genres: "", genreList: [], companies: "", companyList: [], countries: "", countryList: [], languages: "", languageList: [], contentRating: "", imDBRating: "", imDBRatingVotes: "", metacriticRating: "", ratings: .none, wikipedia: .none, posters: .none, images: .none, trailer: .none, boxOffice: BoxOffice(budget: "", openingWeekendUSA: "", grossUSA: "", cumulativeWorldwideGross: ""), tagline: .none, keywords: "", keywordList: [], similars: [], tvSeriesInfo: .none, tvEpisodeInfo: .none, errorMessage: ""))
    
    var movies = Dynamic(Movies(items: [], errorMessage: ""))
    
    //MARK: Connect with Network
    private lazy var network: Network = {
        return Network()
    }()
    
    //MARK: Load Data from Network
    func shareData(){
//        network.getAllTest { movieData in
//            self.movies.value = movieData
//        }
//        network.getMovies { movieData in
//            self.movies.value = movieData
//        }
        APIAuth().getTopMovies { movieData in
            switch movieData{
            case.success(let data):
                self.movies.value = data
                break
            case.failure(_):
                break
            }
        }
        
        
    }
}
