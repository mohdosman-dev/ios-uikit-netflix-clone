//
//  SearchViewController.swift
//  NetflixClone
//
//  Created by Mohammed Osman on 06/04/2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var discoverList: [Movie] = [Movie]()
    
    private let discoverTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        return tableView
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultViewController())
        controller.searchBar.placeholder = "Search for a Movie or TV show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        title = "Search"
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(discoverTableView)
        
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .label
        
        discoverTableView.dataSource = self
        discoverTableView.delegate = self
        
        searchController.searchResultsUpdater = self
        
        fetchDiscoverData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        discoverTableView.frame = view.bounds
    }
    
    private func fetchDiscoverData() {
        APICaller.shared.getDiscoverMovies {[weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let list):
                self.discoverList = list
                DispatchQueue.main.async {
                    self.discoverTableView.reloadData()
                }
            case .failure(let failure):
                print("Error: \(failure)")
            }
        }
    }
    
}

// MARK: - Extension
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discoverList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = self.discoverList[indexPath.row]
        let model = MovieViewModel(title: movie.title ?? "N/A", posterImage: movie.posterPath)
        cell.configure(with: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
        !query.trimmingCharacters(in: .whitespaces).isEmpty,
        query.trimmingCharacters(in: .whitespaces).count >= 3,
        let controller = searchController.searchResultsController as? SearchResultViewController
         else { return }
        
        APICaller.shared.search(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    controller.results = results
                    controller.resultCollectionview.reloadData()
                case .failure(let error):
                    print("Cannot search for \(query): \(error)")
                }
            }
        }
    }
}
