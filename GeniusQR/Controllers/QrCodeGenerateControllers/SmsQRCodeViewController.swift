//
//  Untitled.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 30/09/24.
//

import UIKit

class SmsQRCodeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    func setupUI() {
        // Configure sua UI aqui
        let titleLabel = UILabel()
        titleLabel.text = "Criar QR Code para SMS"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        
        // Adicione campos de entrada, botões, etc., conforme necessário
    }
}
