//
//  SaveViewController.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 25/03/2023.
//

import UIKit
import SnapKit

class SaveViewController: UIViewController {
    
    private lazy var contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 450)
    
    private lazy var scrollView: UIScrollView = {
        let scrollV = UIScrollView(frame: .zero)
        scrollV.contentSize = contentSize
        scrollV.frame = self.view.bounds
        scrollV.contentInsetAdjustmentBehavior = .never
        scrollV.delegate = self
        return scrollV
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.frame.size = contentSize
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var netflixLogo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "netflix-logo")
        return image
    }()
    
    private lazy var myListLabel: UILabel = {
        let label = UILabel()
        label.text = "My List"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var savedTable: UITableView = {
        let tableV = UITableView()
        tableV.register(SavedTableCell.self, forCellReuseIdentifier: SavedTableCell.identifier)
        tableV.isScrollEnabled = false
        tableV.showsVerticalScrollIndicator = false
        tableV.delegate = self
        tableV.dataSource = self
        tableV.backgroundColor  = .black
        return tableV
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
    }
    
    private func setupConstraints(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(netflixLogo)
        netflixLogo.snp.makeConstraints { make in
            make.leading.equalTo(35)
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(15)
            make.height.equalTo(53)
            make.width.equalTo(57)
        }
        
        contentView.addSubview(myListLabel)
        myListLabel.snp.makeConstraints { make in
            make.centerY.equalTo(netflixLogo)
            make.leading.equalTo(netflixLogo.snp.trailing).offset(15)
        }
        
        contentView.addSubview(savedTable)
        savedTable.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(netflixLogo.snp.bottom).offset(25)
        }
    }

}


extension SaveViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SavedTableCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 620
    }
}

extension SearchViewController: UIScrollViewDelegate {
    
}
