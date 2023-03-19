//
//  MoviesCollectionCell.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 19/03/2023.
//

import Foundation
import SnapKit
import UIKit

class MoviesCollectionCell: UICollectionViewCell {
    
    static let identifier = "Collection Cell"
    
    private lazy var posterImage: UIImageView = {
        let imageV = UIImageView()
        imageV.backgroundColor = .orange
        return imageV
    }()
    
    
    
    
    override func layoutSubviews(){
        super.layoutSubviews()
        setupConstraints()
    }
    
    func setupConstraints(){
        contentView.addSubview(posterImage)
        posterImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
}
