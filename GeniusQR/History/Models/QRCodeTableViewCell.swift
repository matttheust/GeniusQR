//
//  QRCodeTableViewCell.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 15/10/24.
//

import UIKit

class QRCodeTableViewCell: UITableViewCell {
    
    static let identifier = "QRCodeTableViewCell"
    
    let qrCodeImageView = UIImageView()
    let titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        qrCodeImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(qrCodeImageView)
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            qrCodeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            qrCodeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            qrCodeImageView.widthAnchor.constraint(equalToConstant: 50),
            qrCodeImageView.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: qrCodeImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    func configure(with image: UIImage, title: String) {
        qrCodeImageView.image = image
        titleLabel.text = title
    }
}
