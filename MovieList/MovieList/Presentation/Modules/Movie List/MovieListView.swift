//
//  MovieListView.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import UIKit
import SnapKit

protocol MovieListViewDelegate: AnyObject {
    func movieListView(movieListView: MovieListView, didSelectItemAt indexPath: IndexPath)
    func movieListView(movieListView: MovieListView, favouriteSelectedAt indexPath: IndexPath)
    func movieListViewWillBeginDragging()
    func movieListViewDidRequestMoreData(movieListView: MovieListView)
}

class MovieListView: UIView {
    
    private let dataSource: MovieListDataSource
    
    private var tableView: UITableView!
    
    weak var delegate: MovieListViewDelegate?
    
    init(dataSource: MovieListDataSource) {
        self.dataSource = dataSource
        super.init(frame: .zero)
        
        dataSource.delegate = self
        initUIStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Instantiate this view from code")
    }
    
    private func initUIStack() {
        backgroundColor = .mvWhite
        initTableView()
    }
    
    private func initTableView() {
        let tableView = UITableView(frame: .zero, style: .plain)
        addSubview(tableView)
        self.tableView = tableView
        tableView.snp.makeConstraints { [weak self] make in
            guard let sSelf = self else { return }
            make.top.equalTo(sSelf.snp.topMargin)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(sSelf.snp.bottomMargin)
        }
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .mvBackground
        
        tableView.registerXibs(xibNames: [MovieListItemCell.classIdentifier])
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.reloadData()
    }
    
    func load(items: [CurrentMovie], favouriteItems: [Int: CurrentMovie]) {
        dataSource.items = items
        dataSource.favouriteItems = favouriteItems
        tableView.reloadData()
    }
}

extension MovieListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MovieListItemCell.defaultHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.movieListView(movieListView: self, didSelectItemAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if dataSource.items.count - indexPath.row < 5 {
            delegate?.movieListViewDidRequestMoreData(movieListView: self)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delegate?.movieListViewWillBeginDragging()
    }
}

extension MovieListView: MovieListDataSourceDelegate {
    func movieListFavouriteSelected(at indexPath: IndexPath) {
        delegate?.movieListView(movieListView: self, favouriteSelectedAt: indexPath)
    }
}
