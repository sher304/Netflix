//
//  SavedTableCell.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 25/03/2023.
//

import Foundation
import UIKit
import SnapKit


class SavedTableCell: UITableViewCell {
    
    static let identifier = "SavedTableCell"
    
    private lazy var savedCollectioV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.register(SavedCollectionCell.self, forCellWithReuseIdentifier: SavedCollectionCell.identifier)
        collectionV.delegate = self
        collectionV.dataSource = self
        return collectionV
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupconstraints()
    }
    
    private func setupconstraints(){
        contentView.backgroundColor = .black
        
        contentView.addSubview(savedCollectioV)
        savedCollectioV.snp.makeConstraints { make in
            make.leading.equalTo(15)
            make.bottom.trailing.top.equalToSuperview()
        }
    }
    
}


extension SavedTableCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SavedCollectionCell.identifier, for: indexPath) as? SavedCollectionCell else { return SavedCollectionCell()}
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 153, height: 200)
    }
}

