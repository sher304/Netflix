//
//  Saved Collection Cell.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 25/03/2023.
//

import Foundation
import UIKit
import SnapKit

class SavedCollectionCell: UICollectionViewCell {
    
    static let identifier = "SavedCollection"

    private lazy var posterImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .green
        return image
    }()
    
    private lazy var movieTite: UILabel = {
        let label = UILabel()
        label.text = "MOVIE Title"
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private lazy var movieCrew: UILabel = {
        let label = UILabel()
        label.text = "Crew"
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupconstraints()
    }
    
    private func setupconstraints(){
        contentView.backgroundColor =  .blue
        
        contentView.addSubview(posterImage)
        posterImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        posterImage.addSubview(movieTite)
        movieTite.snp.makeConstraints { make in
            make.leading.equalTo(5)
            make.width.equalTo(contentView.frame.width / 2)
            make.bottom.equalTo(-5)
        }
        
        posterImage.addSubview(movieCrew)
        movieCrew.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(movieTite)
            make.trailing.equalTo(-5)
        }
    }
    
    func fillData(title: String, imageURL: String, crew: String){
        DispatchQueue.main.async {
            self.movieTite.text = title
            self.movieCrew.text = crew
        }
    }

}
