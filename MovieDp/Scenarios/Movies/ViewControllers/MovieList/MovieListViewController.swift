//
//  MovieListViewController.swift
//  MovieDp
//
//  Created by Amr Sayed on 1/5/21.
//

import UIKit

class MovieListViewController: BaseViewController, MovieStoryboardLodable {
    
    // MARK: - Outlets
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Properties
    var viewModel: MoviesViewModel!
    
    // MARK: - VC life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        showDefaultLoader()
        viewModel.fetchMovies()
    
        viewModel.moviesUpdateSubject.subscribe(onNext: { [weak self] in
            self?.hideDefaultLoader()
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)

        viewModel.errorSubject.subscribe(onNext: { [weak self] error in
            self?.hideDefaultLoader()
            self?.showErrorMessage(title: "Error", message: error?.message ?? "Something went wrong")
        }).disposed(by: disposeBag)
        
    }

    func setupUI() {
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UINib(nibName: MovieCell.identifier, bundle: nil),
                           forCellReuseIdentifier: MovieCell.identifier)
    }
}
