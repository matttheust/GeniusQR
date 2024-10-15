//
//  TextQRCodePreviewViewController.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 08/10/24.
//

import UIKit

class UrlQRCodePreviewController: QRCodePreviewController {
    
    // Variável para armazenar a URL
    private var urlData: String?
    
    // Método para configurar o controller com a URL e o título
    func configure(with title: String, url: String) {
        self.cardTitle = title
        self.urlData = url
        self.qrCodeType = .website
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Chamada do método que configura o qr code baseado no tipo do qr e conecta no base
        qrCodeCardView.configure(with: cardTitle ?? "", qrCodeImage: generateQRCode(from: urlData ?? ""), qrCodeTypeIcon: qrCodeType?.icon)
    }
}
