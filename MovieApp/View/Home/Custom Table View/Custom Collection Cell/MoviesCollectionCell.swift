//
//  MoviesCollectionCell.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 19/03/2023.
//

import Foundation
import Kingfisher
import UIKit
import SnapKit


class MoviesCollectionCell: UICollectionViewCell {
    
    //MARK: IDENTIFIER OF CELL
    static let identifier = "Collection Cell"
    
    //MARK: POSTER IMAGE VIEW
    private lazy var posterImage: UIImageView = {
        let imageV = UIImageView()
        return imageV
    }()
    
    //MARK: GRADIENT OF POSTER
    private lazy var gradientOfPoster: GradientView = {
        let gradient = GradientView(gradientStartColor: .black, gradientEndColor: .clear)
        return gradient
    }()
    
    //MARK: MOVIE TITLE
    private lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .heavy)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    //MARK: CREWS TITLE
    private lazy var crewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 8, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    //MARK: RATTING TITLE
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 8, weight: .semibold)
        return label
    }()
    
    override func layoutSubviews(){
        super.layoutSubviews()
        setupConstraints()
    }
    
    //MARK: Fill Data
    func fillData(title: String, crew: String, posterURL: String, rating: String){
        DispatchQueue.main.async { [self] in
            movieTitle.text = title
            crewLabel.text = crew
            ratingLabel.text = rating
            posterImage.kf.setImage(with: URL(string: posterURL))
        }
    }
    
    //MARK: SETUP CONSTRAINTS
    private func setupConstraints(){
        contentView.backgroundColor = .black
        
        contentView.addSubview(posterImage)
        posterImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        posterImage.addSubview(gradientOfPoster)
        gradientOfPoster.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(45)
        }
        
        gradientOfPoster.addSubview(movieTitle)
        movieTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(10)
            make.width.equalTo(contentView.frame.width / 1.2)
        }
        
        gradientOfPoster.addSubview(crewLabel)
        crewLabel.snp.makeConstraints { make in
            make.leading.equalTo(5)
            make.bottom.equalTo(-5)
            make.width.equalTo(contentView.frame.width / 2)
        }
        
        gradientOfPoster.addSubview(ratingLabel)
        ratingLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-15)
            make.centerY.equalTo(crewLabel)
        }
    }
}
