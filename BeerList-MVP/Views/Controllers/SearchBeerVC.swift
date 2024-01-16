//
//  SearchBeerVC.swift
//  BeerList-MVP
//
//  Created by MacBook on 18.01.2024.
//

import UIKit

protocol SearchView: AnyObject {
    func onItemsRetrieval(beers: [Beer])
}

class SearchBeerVC: UIViewController {
    private let beerView = BeerView()
    private let searchController = UISearchController(searchResultsController: nil)
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    var presenter: SearchBeerViewPresenter!
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        setupNavigationTitle()
        setupSearch()
    }
    //MARK: Private methods
    private func setupNavigationTitle() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Search By ID"
        self.navigationItem.accessibilityLabel = "Search By Beer ID"
    }
    
    private func setupSearch() {
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.keyboardType = .numberPad
    }
    
    private func setupSubview() {
        view.backgroundColor = .white
        view.addSubview(beerView)
        view.addSubview(activityIndicator)
        
        beerView.snp.makeConstraints {
            $0.top.equalTo(view.layoutMarginsGuide)
            $0.size.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
//MARK: UISearchResultsUpdating, SearchView
extension SearchBeerVC: UISearchResultsUpdating, SearchView {
    func onItemsRetrieval(beers: [Beer]) {
        activityIndicator.startAnimating()
        if let beer = beers.first {
            self.beerView.setupView(model: beer)
            activityIndicator.stopAnimating()
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text != "" {
            activityIndicator.startAnimating()
            self.presenter.search(id: Int(searchController.searchBar.text ?? "") ?? 0)
            activityIndicator.stopAnimating()
        }
    }
}
