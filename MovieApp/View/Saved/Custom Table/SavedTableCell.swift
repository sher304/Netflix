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
    
    var items: [ResultTest]? = nil
    
    var delegate: MovieTableDelegate? = nil
    
    private lazy var savedCollectioV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.register(SavedCollectionCell.self, forCellWithReuseIdentifier: SavedCollectionCell.identifier)
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.backgroundColor = .black
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
    
    func fetchData(data: [ResultTest], deleagate: MovieTableDelegate){
        DispatchQueue.main.async {
//            print(data, "saved Table")
            self.items = data
            self.delegate = deleagate
            self.savedCollectioV.reloadData()
        }
    }
    
}


extension SavedTableCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print(items?.count, "count table delegate")
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SavedCollectionCell.identifier, for: indexPath) as? SavedCollectionCell else { return SavedCollectionCell()}
        
        let items = items?[indexPath.row]
        cell.fillData(title: items?.name, imageURL: items?.image, crew: items?.type)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 153, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelected(indx: (indexPath.row + 1).description)
    }
}

