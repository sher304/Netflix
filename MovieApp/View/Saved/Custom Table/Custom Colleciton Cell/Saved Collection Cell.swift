//
//  Saved Collection Cell.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 25/03/2023.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit

class SavedCollectionCell: UICollectionViewCell {
    
    static let identifier = "SavedCollection"
    
    private lazy var posterImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .green
        return image
    }()
    
    //MARK: GRADIENT OF POSTER
    private lazy var gradientOfPoster: GradientView = {
        let gradient = GradientView(gradientStartColor: .black, gradientEndColor: .clear)
        return gradient
    }()
    
    private lazy var movieTite: UILabel = {
        let label = UILabel()
        label.text = "MOVIE Title"
        label.font = .systemFont(ofSize: 12, weight: .heavy)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        return label
    }()
    
    private lazy var movieCrew: UILabel = {
        let label = UILabel()
        label.text = "Crew"
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .white
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupconstraints()
    }
    
    //MARK: SetupConstraints
    private func setupconstraints(){
        contentView.backgroundColor =  .blue
        
        contentView.addSubview(posterImage)
        posterImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        posterImage.addSubview(gradientOfPoster)
        gradientOfPoster.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(45)
        }
        
        gradientOfPoster.addSubview(movieTite)
        movieTite.snp.makeConstraints { make in
            make.leading.equalTo(5)
            make.width.equalTo(contentView.frame.width / 2)
            make.bottom.equalTo(-5)
            make.height.equalTo(30)
        }
        
        gradientOfPoster.addSubview(movieCrew)
        movieCrew.snp.makeConstraints { make in
            make.trailing.equalTo(-5)
            make.bottom.equalTo(-5)
            make.width.equalTo(contentView.frame.width / 2)
            make.height.equalTo(30)
        }
        
    }
    
    //MARK: Fill Data
    func fillData(title: String?, imageURL: String?, crew: String?){
        DispatchQueue.main.async {
            self.movieTite.text = title
            self.movieCrew.text = crew
            self.posterImage.kf.indicatorType = .activity
            self.posterImage.kf.setImage(with: URL(string: imageURL ?? ""))
        }
    }
    
}
