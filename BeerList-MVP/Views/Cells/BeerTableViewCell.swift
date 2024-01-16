//
//  BeerTableViewCell.swift
//  BeerList-MVP
//
//  Created by MacBook on 18.01.2024.
//

import UIKit
import SnapKit
import Then
import Kingfisher

final class BeerTableViewCell: UITableViewCell {
    //MARK: UI elements
    private let beerImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.snp.makeConstraints {
            $0.height.width.equalTo(100)
        }
    }
    private let idLabel = UILabel().then {
        $0.textColor = UIColor.orange
        $0.text = "ID"
        $0.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
    }
    private let nameLabel = UILabel().then {
        $0.text = "User Name"
    }
    private let descriptionLabel = UILabel().then {
        $0.text = "Description"
        $0.textColor = UIColor.gray
        $0.numberOfLines = 3
    }
    private let nameStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .top
    }
    private let mainStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 10
    }
    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubview()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    // MARK: Public Methods
    func configureCell(model: Beer) {
        DispatchQueue.main.async { // Change UI
            self.beerImageView.kf.setImage(with: URL(string: model.imageURL ?? ""))
            self.idLabel.text = String(model.id ?? 0)
            self.nameLabel.text =  model.name ?? ""
            self.descriptionLabel.text = model.description ?? ""
        }
    }
    // MARK: Private Methods
    private func setupSubview() {
        addSubview(mainStackView)
        nameStackView.addArrangeSubviews([idLabel, nameLabel, descriptionLabel])
        mainStackView.addArrangeSubviews([beerImageView, nameStackView])
        
        mainStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16).priority(.high)
        }
    }
}
