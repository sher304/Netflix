//
//  SearchTableCell.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 19/03/2023.
//

import Foundation
import Kingfisher
import SnapKit

class SearchTableCell: UITableViewCell{
    
    static let identifier = "Search Cell"
    
    private lazy var posterImage: UIImageView = {
        let imageV = UIImageView()
        imageV.backgroundColor = .orange
        return imageV
    }()
    
    private lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.text = "The Shawshank Redemption"
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    override func layoutSubviews(){
        super.layoutSubviews()
        setupConstraints()
    }
    
    //MARK: SetupConstraints
    private func setupConstraints(){
        contentView.backgroundColor = .black
        
        contentView.addSubview(posterImage)
        posterImage.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(2)
            make.bottom.equalTo(-2)
            make.width.equalTo(contentView.frame.width / 2.5)
        }
        
        contentView.addSubview(movieTitle)
        movieTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(posterImage.snp.trailing).offset(5)
        }
    }
    
    //MARK: FIll Data
    func fillData(title: String, url: String){
        DispatchQueue.main.async {
            self.movieTitle.text = title
            self.posterImage.kf.indicatorType = .activity
            self.posterImage.kf.setImage(with: URL(string: url))
        }
    }
}
