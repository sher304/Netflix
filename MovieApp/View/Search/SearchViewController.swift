//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 19/03/2023.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    private lazy var searchBar: UISearchBar = {
        let searchB = UISearchBar()
        searchB.backgroundImage = UIImage()
        searchB.backgroundColor = .darkGray
        searchB.searchTextField.leftView?.tintColor = .white
        searchB.searchTextField.backgroundColor = .darkGray
//        searchB.placeholder = "Search for a show, movie, genre, e.t.c."
        searchB.layer.cornerRadius = 14
        searchB.searchTextField.textColor = .white
        searchB.autocorrectionType = .no
        searchB.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search for a show, movie, genre, e.t.c.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return searchB
    }()
    
    private lazy var searchTable: UITableView = {
        let tableV = UITableView()
        tableV.register(SearchTableCell.self, forCellReuseIdentifier: SearchTableCell.identifier)
        tableV.delegate = self
        tableV.dataSource = self
        tableV.backgroundColor = .black
        return tableV
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
    
    private func setupConstraints(){
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(52)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        view.addSubview(searchTable)
        searchTable.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(15)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SearchTableCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    
}
