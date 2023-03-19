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
    }
    
}
