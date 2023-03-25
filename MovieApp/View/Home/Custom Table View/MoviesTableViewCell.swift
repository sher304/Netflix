//
//  MoviesTableViewCell.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 19/03/2023.
//

import UIKit
import Hero
import SnapKit

protocol MovieTableDelegate {
    func didSelected(indx: String)
}

class MoviesTableViewCell: UITableViewCell {
    
    //MARK: THE CELL'S IDENTIFIER
    static let identifier = "MoviesCell"
    
//    var items: Movies? = nil
    var items: TestAll? = nil
    
    var delegate: MovieTableDelegate? = nil
    
    //MARK: COLLECTION VIEW
    private lazy var moviesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(MoviesCollectionCell.self, forCellWithReuseIdentifier: MoviesCollectionCell.identifier)
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .black
        return collection
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    //MARK: SETUP CONSTRAINTS
    private func setupConstraints(){
        contentView.backgroundColor = .black
        
        contentView.addSubview(moviesCollection)
        moviesCollection.snp.makeConstraints { make in
            make.trailing.bottom.top.equalToSuperview()
            make.leading.equalTo(15)
        }
    }
    
    func fetchData(data: TestAll, delegate: MovieTableDelegate){
        DispatchQueue.main.async { [self] in
            items = data
            self.delegate = delegate
            moviesCollection.reloadData()

        }
    }
    
//    func fetchData(data: Movies, delegate: MovieTableDelegate){
//        DispatchQueue.main.async { [self] in
//            items = data
//            self.delegate = delegate
//            moviesCollection.reloadData()
//
//        }
//    }
    
}

//MARK: COLLECTION VIEW SETTINGS
extension MoviesTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    //MARK: COLLECTION VIEW'S ROW
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return items?.items.count ?? 0
        return items?.results.count ?? 0
    }
    
    //MARK: CONNECT WITH THE CUSTOM COLLECTION CELL
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionCell.identifier, for: indexPath) as? MoviesCollectionCell else { return MoviesCollectionCell()}
        
        
//        guard let items = items?.items[indexPath.row] else { return MoviesCollectionCell()}
        guard let items = items?.results[indexPath.row] else { return MoviesCollectionCell()}
        let titles = items.name
        let crews = items.created
        let posterURL = items.image
        cell.fillData(title: titles, crew: crews, posterURL: posterURL, rating: items.type)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row + 1
        delegate?.didSelected(indx: index.description)
    }
}
