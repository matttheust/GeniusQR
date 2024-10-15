//
//  QRCodeTableViewCell.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 15/10/24.
//

import UIKit

class QRCodeTableViewCell: UITableViewCell {
    
    static let identifier = "QRCodeTableViewCell"
    
    let typeIconImageView = UIImageView() // Apenas o ícone do tipo
    let titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        typeIconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Configurar titleLabel para permitir múltiplas linhas
        titleLabel.numberOfLines = 0 // Permite que o label tenha múltiplas linhas
        titleLabel.lineBreakMode = .byWordWrapping // Quebrar a linha por palavras

        contentView.addSubview(typeIconImageView) // Adicionando o ícone à célula
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            typeIconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            typeIconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            typeIconImageView.widthAnchor.constraint(equalToConstant: 30),
            typeIconImageView.heightAnchor.constraint(equalToConstant: 30),

            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: typeIconImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    func configure(with title: String, icon: UIImage?) {
        titleLabel.text = title
        typeIconImageView.image = icon // Configura o ícone do tipo
    }
}
