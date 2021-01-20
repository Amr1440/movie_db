//
//  MovieDetailsViewController.swift
//  MovieDp
//
//  Created by Amr Sayed on 1/5/21.
//

import UIKit
import TagListView
import AlamofireImage

class MovieDetailsViewController: BaseViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var tagView: TagListView!
    @IBOutlet weak var movieDetailsTextView: UILabel!
    
    var selectedMovie: Movie?
    var viewModel: MoviesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDefaultLoader()
        setupUI()
        
        viewModel?.movieDetailsUpdateSubject.subscribe(onNext: { [weak self] movie in
            DispatchQueue.main.async {
                self?.hideDefaultLoader()
                self?.selectedMovie = movie
                self?.setupUI()
            }
        }).disposed(by: disposeBag)
        
        viewModel?.errorSubject.subscribe(onNext: { [weak self] error in
            DispatchQueue.main.async {
                self?.hideDefaultLoader()
                self?.showErrorMessage(title: "Error", message: error?.message ?? "Something went wrong")
            }
            
        }).disposed(by: disposeBag)
        
        viewModel?.fetchMovieDetails(movieId: selectedMovie?.id ?? 0)
        
    }
    
    func setupUI () {
        if let url = URL(string: Configurations.ImagesUrl + (selectedMovie?.posterPath ?? "")) {
            movieImage.af_setImage(withURL: url)
        }
        titleLabel.text = selectedMovie?.title
        movieDetailsTextView.text = selectedMovie?.overview
        releaseDate.text = selectedMovie?.releaseDate
        
        if let geners = selectedMovie?.genres {
            let genersNames = geners.map{$0.name ?? ""}
            self.tagView.addTags(genersNames)
        }
    }
}
