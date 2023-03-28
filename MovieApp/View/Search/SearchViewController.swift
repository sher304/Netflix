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
    
    //MARK: Search View Model
    private lazy var searchViewModel: SearchViewModel = {
        return SearchViewModel()
    }()
    
    //MARK: Search Bar
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
        searchB.autocapitalizationType = .none
        return searchB
    }()
    
    //MARK: Search Table
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
    
    //MARK: Setup Constraints
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

    //MARK: Binder
    func binder(){
        searchViewModel.shareData()
        searchViewModel.movieData.bind { items in
            DispatchQueue.main.async {
                self.searchTable.reloadData()
            }
        }
    }
    
    //MARK: Dismiss Tapped
    @objc func dismissTapped(){
        dismiss(animated: true)
    }
    
}

//MARK: Work with Table Delegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //MARK: return amount
        return searchViewModel.sortedMovies.count
    }
    
    //MARK: link with cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SearchTableCell()
        let items = searchViewModel.sortedMovies[indexPath.row]
        cell.fillData(title: items.title, url: items.image)
        return cell
    }
    
    //MARK: size of cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}


//MARK: Search Bar Delegate
extension SearchViewController: UISearchBarDelegate{
    
    //MARK: Text Did Changed
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchViewModel.setTitle(title: searchBar.text ?? "")
        binder()
    }
    
    //MARK: Did Selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        let items = searchViewModel.sortedMovies[indexPath.row]
        vc.fetchId(id: items.id.description, url: items.image)
        vc.hero.isEnabled = true
        present(vc, animated: true)
    }
    
}
