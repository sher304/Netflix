//
//  WheelColleitonCell.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 28/03/2023.
//

import Foundation
import Kingfisher
import UIKit
import SnapKit

class WheelColleitonCell: UICollectionViewCell {
    
    //MARK: Identifier
    static let identifier = "WheelCell"
    
    private lazy var imagesOfActors: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .brown
        return image
    }()

    //MARK: GRADIENT VIEW
    private lazy var gradientView: GradientView = {
        let view = GradientView(gradientStartColor: .black, gradientEndColor: .clear)
        return view
    }()
    
    //MARK: Title of Image
    private lazy var titleOfImage: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    //MARK: Fetch Data
    func fetch(title: String, url: String){
        DispatchQueue.main.async {
            self.imagesOfActors.kf.indicatorType = .activity
            self.imagesOfActors.kf.setImage(with: URL(string: url))
            self.titleOfImage.text = title
        }
    }
    
    //MARK: Set Constriants
    private func setupConstraints(){
        contentView.addSubview(imagesOfActors)
        imagesOfActors.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imagesOfActors.addSubview(gradientView)
        gradientView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(65)
        }
        
        gradientView.addSubview(titleOfImage)
        titleOfImage.snp.makeConstraints { make in
            make.leading.equalTo(5)
            make.trailing.equalTo(-5)
            make.height.equalTo(contentView.frame.height / 2)
        }
    }
}
