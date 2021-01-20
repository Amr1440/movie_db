//
//  MovieListViewController+UITable.swift
//  MovieDp
//
//  Created by Amr Sayed on 1/5/21.
//

import UIKit
import AlamofireImage

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getMoviesList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell
        
        let movie = viewModel.getMoviesList()[indexPath.row]
        
        cell?.adultLabel.isHidden = !(movie.adult)
        cell?.movieTitleLabel.text = movie.title
        cell?.MovieDescLabel.text = movie.overview
        cell?.releaseDateLabel.text = movie.releaseDate
        
        if let url = URL(string: Configurations.ImagesUrl + (movie.posterPath ?? "")) {
            cell?.movieImage.af_setImage(withURL: url)
        }
        
        return cell ?? UITableViewCell()
    }
}

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movie = viewModel.getMovie(index: indexPath.row) {
            let detialsVC = storyboard?.instantiateViewController(identifier: "MovieDetailsViewController") as? MovieDetailsViewController
            detialsVC?.selectedMovie = movie
            detialsVC?.viewModel = viewModel
            self.show(detialsVC ?? UIViewController(), sender: nil)
        } else {
            showErrorMessage(title: "Error", message: "Please check your internet connection")
        }
        
    }
    
}

extension MovieListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.last?.row == viewModel.getMoviesList().count - 1 {
            viewModel.fetchMovies()
            print("Fetch New Page")
        }
    }
}
