//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by Mohammed Osman on 06/04/2023.
//

import UIKit

enum Sections: Int {
    case trendingMovies = 0
    case popular = 1
    case trendingTv = 2
    case upcoming = 3
    case topRated = 4
}

class HomeViewController: UIViewController {
    
    let sectionTitles = ["Trending Movies", "Popular", "Trending Tv", "Upcoming Movies", "Top Rated"]
    
    
    let homeFeedTable: UITableView =  {
        let table = UITableView(frame: .zero, style: .grouped)
        
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        homeFeedTable.showsHorizontalScrollIndicator = false
        
        let header = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = header
        
        configureNavigation()
    }
    
    private func configureNavigation() {
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .plain, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .label
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    
    
    private func getTrendingTv() {
        APICaller.shared.getTrendingTvs { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else{
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case Sections.trendingTv.rawValue:
            APICaller.shared.getTrendingTvs { result in
                switch result {
                case .success(let tvs):
                    cell.configure(with: tvs)
                    
                case .failure(let error):
                    print("\(String(describing: error))")
                }
            }
            break
        case Sections.popular.rawValue:
            APICaller.shared.getPopular { result in
                switch result {
                case .success(let tvs):
                    cell.configure(with: tvs)
                    
                case .failure(let error):
                    print("\(String(describing: error))")
                }
            }
            break
        case Sections.trendingMovies.rawValue:
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case .success(let tvs):
                    cell.configure(with: tvs)
                    
                case .failure(let error):
                    print("\(String(describing: error))")
                }
            }
            break
        case Sections.topRated.rawValue:
            APICaller.shared.getTopRated { result in
                switch result {
                case .success(let tvs):
                    cell.configure(with: tvs)
                    
                case .failure(let error):
                    print("\(String(describing: error))")
                }
            }
            break
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20,
                                         y: header.bounds.origin.y + 20,
                                         width: header.bounds.width,
                                         height: header.bounds.height)
        header.textLabel?.textColor = .label
        header.textLabel?.text = header.textLabel?.text?.capitalized
    }
}
