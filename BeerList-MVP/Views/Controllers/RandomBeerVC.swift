//
//  RandomBeerVC.swift
//  BeerList-MVP
//
//  Created by MacBook on 18.01.2024.
//

import UIKit
import Then

protocol RandomView: AnyObject {
    func onItemsRetrieval(beers: [Beer])
}

class RandomBeerVC: UIViewController {
    private let randomView = BeerView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    var presenter: RandomBeerViewPresenter!
    
    private let randomButton = UIButton().then {
        $0.setTitle("Roll Random", for: .normal)
        $0.backgroundColor = UIColor.orange
    }
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationTitle()
        addTargets()
        self.presenter.getRandom()
    }
    //MARK: Private methods
    private func setupNavigationTitle() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Random Beer"
        self.navigationItem.accessibilityLabel = "Random by Button"
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(randomView)
        view.addSubview(activityIndicator)
        randomView.addSubview(randomButton)
        
        randomView.snp.makeConstraints {
            $0.top.equalTo(view.layoutMarginsGuide)
            $0.size.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        randomButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.layoutMarginsGuide).offset(-30)
            $0.width.equalTo(view.snp.width).offset(-30)
            $0.height.equalTo(40)
        }
    }
    
    private func addTargets() {
        randomButton.addTarget(self, action: #selector(randomButtonTapped), for: .touchUpInside)
    }
    //MARK: Objc methods
    @objc private func randomButtonTapped() {
        self.presenter.getRandom()
    }
}
//MARK: - RandomView
extension RandomBeerVC: RandomView {
    func onItemsRetrieval(beers: [Beer]) {
        activityIndicator.startAnimating()
        self.randomView.setupView(model: beers.first ?? Beer(id: 0, name: "", description: "", imageURL: ""))
        activityIndicator.stopAnimating()
    }
}
