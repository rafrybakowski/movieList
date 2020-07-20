//
//  MovieDetailsView.swift
//  MovieList
//
//  Created by Rafał Rybakowski on 18/07/2020.
//  Copyright © 2020 Rafał Rybakowski. All rights reserved.
//

import UIKit

class MovieDetailsView: UIView {
    
    private let dataSource: MovieDetailsDataSource
    
    private var tableView: UITableView!
    
    private var defaultPosterHeight: CGFloat {
        return UIScreen.main.bounds.size.width * 1.5
    }
    
    init(dataSource: MovieDetailsDataSource) {
        self.dataSource = dataSource
        super.init(frame: .zero)
        
        initUIStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Instantiate this view from code")
    }
    
    private func initUIStack() {
        backgroundColor = .mvBackground
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
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 1000 // iOS 10 compatibility necessity, do not remove unless support dropped
        tableView.separatorStyle = .none
        tableView.backgroundColor = .mvBackground
        
        tableView.registerXibs(xibNames: [MovieDetailsPosterCell.classIdentifier,
                                          MovieDetailsInfoCell.classIdentifier,
                                          MovieDetailsOverviewCell.classIdentifier])
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.reloadData()
    }
}

extension MovieDetailsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellIdentifier = dataSource.cells[indexPath.row]
        switch cellIdentifier {
        case MovieDetailsPosterCell.classIdentifier:
            return defaultPosterHeight
        default:
            return UITableView.automaticDimension
        }
    }
}
