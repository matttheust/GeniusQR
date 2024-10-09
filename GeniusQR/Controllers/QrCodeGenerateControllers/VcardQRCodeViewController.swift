//
//  Untitled.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 30/09/24.
//

import UIKit

class VcardQRCodeViewController: UIViewController {
    
    // MARK: - UI Elements
    private let titleLabel = UILabel()
    private let urlTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        titleLabel.text = "Adicionar URL"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // Configure TextField
        urlTextField.placeholder = "URL"
        urlTextField.borderStyle = .roundedRect
        urlTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(urlTextField)

        // Setup Constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            urlTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            urlTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            urlTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
