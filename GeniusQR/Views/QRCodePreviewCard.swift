//
//  QRCodeCardView.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 01/10/24.
//

import UIKit

class QRCodePreviewCard: UIView {
    
    private let backgroundImageView = UIImageView()
    private let titleLabel = UILabel()
    public let qrCodeImageView = UIImageView()
    private let qrCodeTypeIconImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    // Este inicializador é necessário para suportar a inicialização a partir de Storyboards ou XIBs.
    // Ele deve ser implementado para que a view possa ser instanciada corretamente quando carregada dessa forma.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI() 
    }
    
    private func setupUI() {

        setupAppearance()
        setupLayout()
    }
    
    private func setupAppearance() {
        // Configura a imagem de fundo do meu asset "cardBackground"
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.image = UIImage(named: "cardBackground")
        backgroundImageView.contentMode = .scaleAspectFill
        addSubview(backgroundImageView)
        

        // Configura o titleLabel que virá de cada tipo de QR Code

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 36, weight: .bold)
        titleLabel.textColor = .white
        addSubview(titleLabel)
        

        // QR CODE

        qrCodeImageView.translatesAutoresizingMaskIntoConstraints = false
        qrCodeImageView.contentMode = .scaleAspectFit
        addSubview(qrCodeImageView)
        

        // Configura o icone do tipo do QR Code
        qrCodeTypeIconImageView.translatesAutoresizingMaskIntoConstraints = false
        qrCodeTypeIconImageView.tintColor = .white
        addSubview(qrCodeTypeIconImageView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            // Background
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            

            // Label do título Constraints
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
