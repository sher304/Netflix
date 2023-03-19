//
//  MoviesTableViewCell.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 19/03/2023.
//

import UIKit
import SnapKit

class MoviesTableViewCell: UITableViewCell {
    
    static let identifier = "MoviesCell"
    
    private lazy var moviesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(MoviesCollectionCell.self, forCellWithReuseIdentifier: MoviesCollectionCell.identifier)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .purple
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    private func setupConstraints(){
        contentView.addSubview(moviesCollection)
        moviesCollection.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}


extension MoviesTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionCell.identifier, for: indexPath)
        cell.backgroundColor = .orange
        return cell
    }
}
