//
//  Untitled.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 30/09/24.
//

import UIKit

class LinkQRCodeController: UIViewController {
    
    // MARK: - UI Elements
    private let titleLabel = UILabel()
    private let linkTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        titleLabel.text = "Adicionar Link"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // Configure TextField
        linkTextField.placeholder = "URL"
        linkTextField.borderStyle = .roundedRect
        linkTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(linkTextField)

        // Setup Constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            linkTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            linkTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            linkTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
