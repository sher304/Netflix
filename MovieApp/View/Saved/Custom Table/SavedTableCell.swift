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
    
    var dataOfResult: [Item]? = nil
    
    var delegate: MovieTableDelegate? = nil
    
     private lazy var refreshControl: UIRefreshControl = {
         let refrechC = UIRefreshControl()
         refrechC.addTarget(self, action: #selector(refreshPulled(sender:)), for: .valueChanged)
         return refrechC
     }()
     
    
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
        savedCollectioV.refreshControl = refreshControl
    }
    
    //MARK: Setup Constraints
    private func setupconstraints(){
        contentView.backgroundColor = .black
        
        contentView.addSubview(savedCollectioV)
        savedCollectioV.snp.makeConstraints { make in
            make.leading.equalTo(15)
            make.bottom.trailing.top.equalToSuperview()
        }
    }
    
    
    @objc func refreshPulled(sender: UIRefreshControl){
        SavedViewModel.shared.filtredData.bind { _ in
            DispatchQueue.main.async {
                self.savedCollectioV.reloadData()
            }
        }
        sender.endRefreshing()
    }
    
    //MARK: Fetch Data
    func fetchData(data: [Item], deleagate: MovieTableDelegate){
        DispatchQueue.main.async {
            self.dataOfResult = data
            self.delegate = deleagate
            self.savedCollectioV.reloadData()
        }
    }
    
}

//MARK: Extenstion of Collection View Delegate
extension SavedTableCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    //MARK: Cont of Items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataOfResult?.count ?? 0
    }
    
    //MARK: Link with Custom Collection Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SavedCollectionCell.identifier, for: indexPath) as? SavedCollectionCell else { return SavedCollectionCell()}
        let items = dataOfResult?[indexPath.row]
        cell.fillData(title: items?.title, imageURL: items?.image, crew: items?.crew)
        return cell
    }
    
    //MARK: Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 153, height: 200)
    }
    
    //MARK: Did Selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = dataOfResult?[indexPath.row].id
        delegate?.didSelected(indx: (data)?.description ?? "")
    }
}

