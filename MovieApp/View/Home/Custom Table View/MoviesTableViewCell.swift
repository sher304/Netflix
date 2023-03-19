//
//  MoviesTableViewCell.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 19/03/2023.
//

import UIKit
import SnapKit

class MoviesTableViewCell: UITableViewCell {
    
    //MARK: THE CELL'S IDENTIFIER
    static let identifier = "MoviesCell"
    
    //MARK: COLLECTION VIEW
    private lazy var moviesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
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
    
    //MARK: SETUP CONSTRAINTS
    private func setupConstraints(){
        contentView.backgroundColor = .purple
        contentView.addSubview(moviesCollection)
        moviesCollection.snp.makeConstraints { make in
            make.trailing.bottom.top.equalToSuperview()
            make.leading.equalTo(10)
        }
    }

}

//MARK: COLLECTION VIEW SETTINGS
extension MoviesTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    //MARK: COLLECTION VIEW'S ROW
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    //MARK: CONNECT WITH THE CUSTOM COLLECTION CELL
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionCell.identifier, for: indexPath)
        cell.backgroundColor = .orange
        return cell
    }
    
    //MARK: FRAME OF THE CELL
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 153, height: 200)
    }
    
    //MARK: SPACING BETWEEN CELLS
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 35
    }
}
