//
//  TextQRCodePreviewViewController.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 08/10/24.
//

import UIKit

class UrlQRCodePreviewController: QRCodePreviewController {
    
    // Variável para armazenar a URL
    private var url: String?
    
    // Método para configurar o controller com a URL e o título
    func configure(with title: String, url: String) {
        self.cardTitle = title
        self.url = url
        self.qrCodeType = .website
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Chamada do método configure
        qrCodeCardView.configure(with: cardTitle ?? "", qrCodeImage: generateQRCode(from: url ?? ""), qrCodeTypeIcon: qrCodeType?.icon)
    }
}
