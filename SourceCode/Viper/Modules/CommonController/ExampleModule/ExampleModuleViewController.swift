//
//  ExampleModuleViewController.swift
//

import UIKit

///
class ExampleModuleViewController: BaseViewController<ExampleModuleInteractor> {
    
    // MARK: - Variables
    ///
    var tableViewDataSource: MoviesTableViewDataSource?
    
    // MARK: - Outlets
    ///
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewDataSource = MoviesTableViewDataSource(tableView: tableView)
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDataSource
        showProgressHudView()
        interactor?.getMovies(completion: { success in
            self.hideProgressHudView()
            if success {
                if let movies = self.interactor?.movies {
                    DispatchQueue.main.async {
                        self.tableViewDataSource?.reloadTableView(with: movies)
                    }
                }
            }
        })  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
}
