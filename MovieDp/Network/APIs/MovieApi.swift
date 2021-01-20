//
//  MovieApi.swift
//  MovieDp
//
//  Created by Amr Sayed on 1/5/21.
//

import Alamofire
import PromiseKit
import RxSwift
import UIKit

class MovieApi: Api {
    init(params: RequestParamters) {
        super.init()
        self.params = params
    }
    
    private var movieID = 0
    
    enum APIRouter: Requestable {
        case fetchAllMovies(MovieApi)
        case fetchMovieDetails(MovieApi)
        
        var path: String {
            switch self {
            case .fetchAllMovies:
                return "movie/popular"
            case let .fetchMovieDetails(api):
                return "movie/\(api.movieID)"
            }
        }
        
        var baseUrl: URL {
            switch self {
            case .fetchAllMovies, .fetchMovieDetails:
                return Configurations.BaseUrl
            }
        }
        
        var method: HTTPMethod {
            switch self {
            case .fetchAllMovies, .fetchMovieDetails:
                return .get
            }
        }
        
        var parameters: Parameters? {
            switch self {
            case let .fetchAllMovies(api), let .fetchMovieDetails(api):
                return api.params?.getParamsAsJson()
            }
        }
    }
}

extension MovieApi {
    func fetchAllMovies() -> Observable<AllMoviesResponse> {
        return Observable.create { observable in
            let callBack: Promise<AllMoviesResponse> = self.fireRequestWithSingleResponse(requestable: APIRouter.fetchAllMovies(self))
            
            callBack.get { respose in
                observable.onNext(respose)
                observable.onCompleted()
            }.catch { error in
                observable.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func fetchMovieDetails(movieId: Int) -> Observable<Movie> {
        self.movieID = movieId
        return Observable.create { observable in
            let callBack: Promise<Movie> = self.fireRequestWithSingleResponse(requestable: APIRouter.fetchMovieDetails(self))
            
            callBack.get { respose in
                observable.onNext(respose)
                observable.onCompleted()
            }.catch { error in
                observable.onError(error)
            }
            return Disposables.create()
        }
    }
}
