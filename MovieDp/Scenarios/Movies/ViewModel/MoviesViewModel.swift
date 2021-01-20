//
//  MoviesViewModel.swift
//  MovieDp
//
//  Created by Amr Sayed on 1/5/21.
//

import UIKit
import RxSwift
import RealmSwift
import Reachability

class MoviesViewModel: NSObject {
    
    private var disposeBag = DisposeBag()
    private let realm = try! Realm()
    private var moviesList: [Movie]! {
        didSet {
            moviesUpdateSubject.onNext(())
        }
    }
    private var page: Int = 0
    var moviesUpdateSubject: PublishSubject = PublishSubject<Void>()
    var movieDetailsUpdateSubject: PublishSubject = PublishSubject<Movie>()
    var errorSubject: PublishSubject<CustomError?> = PublishSubject()
    
    
    override init() {
        moviesList = Array(realm.objects(Movie.self))
    }
    
    func getMoviesList () -> [Movie] {
        return moviesList
    }
    
    func getMovie (index: Int) -> Movie? {
        if (Configurations.connectionStatus == .connected) && index < moviesList.count{
            return moviesList[index];
        }
        return nil
    }
    
    func fetchMovies() {
        if Configurations.connectionStatus == .disconnected {
            return;
        }
        page += 1
        let api = MovieApi(params: AllMoviesRequestParamters(page: page))
        api.fetchAllMovies().subscribe { [weak self] (response) in
            if self?.page == 1 {
                try! self?.realm.write {
                    self?.realm.deleteAll()
                    self?.realm.add(response.movies ?? [])
                }
                self?.moviesList.removeAll()
            }
            self?.moviesList.append(contentsOf: response.movies ?? [])
        }
        onError: { [weak self] (error) in
            self?.errorSubject.onNext(error as? CustomError)
        } .disposed(by: disposeBag)
    }
    
    func fetchMovieDetails(movieId: Int) {
        let api = MovieApi(params: BaseRequestParamters())
        api.fetchMovieDetails(movieId: movieId).subscribe { [weak self] (response) in
            self?.movieDetailsUpdateSubject.onNext(response)
        }
        onError: { [weak self] (error) in
            self?.errorSubject.onNext(error as? CustomError)
        } .disposed(by: disposeBag)
    }
    
}
