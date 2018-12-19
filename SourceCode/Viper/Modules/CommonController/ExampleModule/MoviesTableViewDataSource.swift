//
//  MoviesTableViewDataSource.swift
//  Viper
//
//  Created by Manikanta on 12/12/18.
//  Copyright © 2018 Siddhant Jain. All rights reserved.
//

import UIKit

class MoviesTableViewDataSource: NSObject {
    
    // MARK: - Variables
    ///
    var tableView: UITableView
    ///
    var movieList: Movies?
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    ///
    func reloadTableView(with data: Movies) {
        movieList = data
        DispatchQueue.main.async {
//            self.tableView.reloadData()
            self.tableView.beginUpdates()
            self.tableView.reloadSections(IndexSet(arrayLiteral: 0), with: .fade)
            self.tableView.endUpdates()
        }
    }
}

extension MoviesTableViewDataSource: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList?.movies.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as? MoviesTableViewCell else {return UITableViewCell()}
        if let data = movieList?.movies[indexPath.row] {
            cell.setupCell(movie: data)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
