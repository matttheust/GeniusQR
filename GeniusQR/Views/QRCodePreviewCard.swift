//
//  QRCodeCardView.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 01/10/24.
//

import UIKit

class QRCodePreviewCard: UIView {
    
    private let backgroundImageView = UIImageView()
    public let titleLabel = UILabel()
    let qrCodeImageView = UIImageView()
    private let qrCodeTypeIconImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        // Configura a imagem de fundo
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.image = UIImage(named: "cardBackground")
        backgroundImageView.contentMode = .scaleAspectFill
        addSubview(backgroundImageView)
        
        // titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 36, weight: .bold)
        titleLabel.textColor = .white // Cor do texto
        addSubview(titleLabel)
        
        // QR CODE
        qrCodeImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(qrCodeImageView)
        
        // Configura o icone que define o QR CODE
        qrCodeTypeIconImageView.translatesAutoresizingMaskIntoConstraints = false
        qrCodeTypeIconImageView.tintColor = .white
        addSubview(qrCodeTypeIconImageView)

        // Constraints
        NSLayoutConstraint.activate([
            // Background
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            // QR Code
            qrCodeImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            qrCodeImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 30),
            qrCodeImageView.widthAnchor.constraint(equalToConstant: 200),
            qrCodeImageView.heightAnchor.constraint(equalToConstant: 200),
            
            // Ícone do Tipo de QR Code no canto inferior esquerdo
            qrCodeTypeIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            qrCodeTypeIconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 24),
            qrCodeTypeIconImageView.widthAnchor.constraint(equalToConstant: 30),
            qrCodeTypeIconImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configure(with title: String, qrCodeImage: UIImage?, qrCodeTypeIcon: UIImage?) {
        titleLabel.text = title
        qrCodeImageView.image = qrCodeImage
        qrCodeTypeIconImageView.image = qrCodeTypeIcon
    }
}
