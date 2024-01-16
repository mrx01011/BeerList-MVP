//
//  DetailBeerVC.swift
//  BeerList-MVP
//
//  Created by MacBook on 18.01.2024.
//

import UIKit
import SnapKit

class DetailBeerVC: UIViewController {
    private let detailView = BeerView()
    private let beer: Beer
    //MARK: Initialization
    init(beer: Beer) {
        self.beer = beer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
    }
    //MARK: Private methods
    private func setupSubview() {
        view.backgroundColor = .white
        view.addSubview(detailView)
        detailView.setupView(model: beer)
        
        detailView.snp.makeConstraints {
            $0.top.equalTo(view.layoutMarginsGuide)
            $0.size.equalToSuperview()
        }
    }
}

