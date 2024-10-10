//
//  CardView.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 27/09/24.
//

import UIKit

class QRCodeSelectorView: UIView {
    
    var qrCodeType: StaticQRCodeType? // Propriedade para armazenar o tipo de QR code

    private let titleLabel = UILabel()
    private let iconImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCard()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCard() {
        // Definindo as dimensões do card
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 190),
            self.heightAnchor.constraint(equalToConstant: 68)
        ])
        
        // Cores do card com cores do sistema
        backgroundColor = UIColor.systemGray.withAlphaComponent(1.0)
        layer.cornerRadius = 12
        layer.masksToBounds = true

        // Configurando o ícone
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.tintColor = .systemYellow
        addSubview(iconImageView)

        // Configurando o texto
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .white 
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        // Definindo as constraints do ícone e do texto
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),

            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func configure(withTitle title: String, icon: UIImage?) {
        titleLabel.text = title
        iconImageView.image = icon
    }
}
