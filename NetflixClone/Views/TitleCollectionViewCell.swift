//
//  TitleCollectionViewCell.swift
//  NetflixClone
//
//  Created by Mohammed Osman on 10/04/2023.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TitleCollectionViewCell"
    
    private let posterImageview: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(posterImageview)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        posterImageview.frame = contentView.bounds
    }
    
    public func configure(with model: Movie) {
        guard let url = URL(string: "\(Constants.baseImageURL)/\(model.posterPath)") else { return }
        posterImageview.sd_setImage(with: url)
    }
}
