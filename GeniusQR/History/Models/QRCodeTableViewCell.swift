//
//  QRCodeTableViewCell.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 15/10/24.
//

import UIKit

class QRCodeTableViewCell: UITableViewCell {
    
    static let identifier = "QRCodeTableViewCell"
    
    let typeIconImageView = UIImageView() // Ícone do tipo
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
        
        // Configurar titleLabel para permitir apenas uma linha
        titleLabel.numberOfLines = 1 // Apenas uma linha
        titleLabel.lineBreakMode = .byTruncatingTail // Adiciona "..." se não couber
        
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
        // Extraindo apenas a parte do título após o primeiro underscore
        let components = title.split(separator: "_").map(String.init)
        
        // Formata o título apenas com a parte que vem após o primeiro underscore
        if components.count > 1 {
            titleLabel.text = components.dropFirst().joined(separator: " ") // Mantém tudo após o primeiro "_"
        } else {
            titleLabel.text = title // Se não houver underscore, usa o título completo
        }

        typeIconImageView.image = icon // Configura o ícone do tipo
    }
}
