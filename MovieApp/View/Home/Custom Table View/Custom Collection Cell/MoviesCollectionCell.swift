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
    
    private lazy var testView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    
    override func layoutSubviews(){
        super.layoutSubviews()
        setupConstraints()
    }
    
    func setupConstraints(){
        contentView.addSubview(testView)
        testView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
