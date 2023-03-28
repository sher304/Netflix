//
//  SaveViewController.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 25/03/2023.
//

import UIKit
import Hero
import SnapKit

class SaveViewController: UIViewController {

    //MARK: ViewModel
    private var viewModel = SavedViewModel.shared
    
    //MARK: ContentSize
    private lazy var contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 450)
    
    //MARK: Scroll View
    private lazy var scrollView: UIScrollView = {
        let scrollV = UIScrollView(frame: .zero)
        scrollV.contentSize = contentSize
        scrollV.frame = self.view.bounds
        scrollV.contentInsetAdjustmentBehavior = .never
        scrollV.delegate = self
        return scrollV
    }()
    
    //MARK: Content View
    private lazy var contentView: UIView = {
        let view = UIView()
        view.frame.size = contentSize
        view.backgroundColor = .black
        return view
    }()
    
    //MARK: Netflix Logo Image
    private lazy var netflixLogo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "netflix-logo")
        return image
    }()
    
    //MARK: My List Title
    private lazy var myListLabel: UILabel = {
        let label = UILabel()
        label.text = "My List"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    //MARK: Table View
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
        binder()
        setupConstraints()
    }
    
    //MARK: SetupConstraints
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
    
    //MARK: Binder
    private func binder(){
        viewModel.loadView()
        viewModel.filtredData.bind { _ in
            DispatchQueue.main.async {
                self.savedTable.reloadData()
            }
        }
    }
}

//MARK: Extenstion of TableDelegate
extension SaveViewController: UITableViewDelegate, UITableViewDataSource{
    
    //MARK: Number of cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //MARK: Link with Custom Table Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SavedTableCell()
//        cell.fetchData(data: viewModel.filtredData.value, deleagate: self)
        cell.fetchData(data: viewModel.filtredData.value, deleagate: self)
        return cell
    }
    
    //MARK: Heigh of TableCell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 620
    }
}

//MARK: Extension of Scroll Delegate
extension SearchViewController: UIScrollViewDelegate {
    
}

//MARK: Work With Custom Table Delegate
extension SaveViewController: MovieTableDelegate{
    //MARK: Work with Selected Delegate
    func didSelected(indx: String) {
        let vc = DetailViewController()
        vc.hero.isEnabled = true
        vc.hero.modalAnimationType = .slide(direction: .up)
        viewModel.filtredData.value.forEach { i in
            if i.id.description == indx{
                vc.fetchId(id: i.id.description, url: i.image)
            }
        }
        present(vc, animated: true)
    }
}
