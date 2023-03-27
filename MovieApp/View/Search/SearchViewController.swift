//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 19/03/2023.
//

import UIKit
import Hero
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
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binder()
        setupConstraints()
    }
    
    private func setupConstraints(){
        
        view.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.width.height.equalTo(35)
        }
        
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(52)
            make.top.equalTo(dismissButton.snp.bottom).offset(10)
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
    
    @objc func dismissTapped(){
        dismiss(animated: true)
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchViewModel.didChanged ?? false{
            return searchViewModel.sortedItems.count
        }else{
            return searchViewModel.items.value.results.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SearchTableCell()
        if searchViewModel.didChanged ?? false{
            //            let items = searchViewModel.sortedMovies[indexPath.row]
            let items = searchViewModel.sortedItems[indexPath.row]
            cell.fillData(title: items.name, url: items.image)
        }else{
            let items = searchViewModel.items.value.results[indexPath.row]
            cell.fillData(title: items.name, url: items.image)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        let items = searchViewModel.sortedItems[indexPath.row]
        vc.fetchId(id: items.id.description)
        vc.hero.isEnabled = true
        present(vc, animated: true)
    }
    
}
