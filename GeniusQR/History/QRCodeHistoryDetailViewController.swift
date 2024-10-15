//
//  QRCodeHistoryDetailViewController.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 15/10/24.
//

import UIKit

class QRCodeHistoryDetailViewController: UIViewController {
    var qrCodeImage: UIImage?
    var qrCodeTitle: String? // Variável para armazenar o título do QR code

    private let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground

        // Configuração do UIImageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        if let image = qrCodeImage {
            imageView.image = image
        }

        view.addSubview(imageView)

        // Definindo as constraints do imageView
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])

        // Configura o título da barra de navegação com o título do QR code
        navigationItem.title = qrCodeTitle
    }
}
