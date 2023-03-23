//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 19/03/2023.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    
    
    private lazy var searchViewModel: SearchViewModel = {
        return SearchViewModel()
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchB = UISearchBar()
        searchB.backgroundImage = UIImage()
        searchB.backgroundColor = .darkGray
        searchB.searchTextField.leftView?.tintColor = .white
        searchB.searchTextField.backgroundColor = .darkGray
        searchB.layer.cornerRadius = 14
        searchB.searchTextField.textColor = .white
        searchB.autocorrectionType = .no
        searchB.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search for a show, movie, genre, e.t.c.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        searchB.delegate = self
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
        binder()
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
    
    func binder(){
        searchViewModel.shareData()
        searchViewModel.items.bind { items in
            DispatchQueue.main.async {
                self.searchTable.reloadData()
            }
        }
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchViewModel.didChanged ?? false{
            return searchViewModel.sortedMovies.count
        }else{
            return searchViewModel.items.value.items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SearchTableCell()
        if searchViewModel.didChanged ?? false{
            let items = searchViewModel.items.value.items[indexPath.row]
            cell.fillData(title: items.fullTitle, url: items.image)
        }else{
            let items = searchViewModel.items.value.items[indexPath.row]
            cell.fillData(title: items.fullTitle, url: items.image)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension SearchViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchViewModel.setTitle(title: searchBar.text ?? "")
        binder()
    }
    
}
