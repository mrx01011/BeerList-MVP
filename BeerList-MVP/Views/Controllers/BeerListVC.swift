//
//  BeerListVC.swift
//  BeerList-MVP
//
//  Created by MacBook on 18.01.2024.
//

import UIKit

protocol BeerListView: AnyObject {
    func onItemsRetrieval(beers: [Beer])
    func onItemsReset(beers: [Beer])
}

final class BeerListVC: UIViewController {
    private let tableView = UITableView().then {
        $0.register(BeerTableViewCell.self, forCellReuseIdentifier: "BeerTableViewCell")
    }
    private let refreshControl = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var beers: [Beer] = []
    
    var presenter: BeerListViewPresenter!
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addTargets()
        setupNavigationTitle()
        presenter.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    //MARK: Private methods
    private func setupNavigationTitle() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "BeerList"
        self.navigationItem.accessibilityLabel = "BeerList"
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        tableView.addSubview(refreshControl)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func addTargets() {
        refreshControl.addTarget(self, action: #selector(resetView), for: .valueChanged)
    }
    //MARK: Objc methods
    @objc private func resetView() {
        activityIndicator.startAnimating()
        presenter.refresh()
        DispatchQueue.main.async { // Change UI
            self.refreshControl.endRefreshing()
            self.activityIndicator.stopAnimating()
        }
    }
}
//MARK: - UITableViewDelegate, UITableViewDataSource
extension BeerListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeerTableViewCell") as! BeerTableViewCell
        cell.configureCell(model: beers[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if Int(scrollView.contentOffset.y) >= 1800 * presenter.getCurrentPage() {
            presenter.getNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DetailBeerVC(beer: beers[indexPath.row])
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
//MARK: - BeerListView
extension BeerListVC: BeerListView {
    func onItemsRetrieval(beers: [Beer]) {
        self.beers += beers
        DispatchQueue.main.async { // Change UI
            self.activityIndicator.startAnimating()
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    func onItemsReset(beers: [Beer]) {
        self.beers = beers
        DispatchQueue.main.async { // Change UI
            self.activityIndicator.startAnimating()
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
}
