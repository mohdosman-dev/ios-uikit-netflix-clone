//
//  SearchResultViewController.swift
//  NetflixClone
//
//  Created by Mohammed Osman on 11/04/2023.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    public var results: [Movie] = [Movie]()
    
    public let resultCollectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 3) - 10, height: 200)
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(resultCollectionview)
        
        resultCollectionview.delegate = self
        resultCollectionview.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        resultCollectionview.frame = view.bounds
    }

}

// MARK: - Extension
extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        let movie = self.results[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
    
    
}
