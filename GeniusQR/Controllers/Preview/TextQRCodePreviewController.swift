//
//  TextQRCodePreviewViewController.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 08/10/24.
//

import UIKit

class TextQRCodePreviewController: QRCodePreviewController {
    
    func configure(with text: String) {
        self.qrCodeText = text
        self.cardTitle = text
        self.qrCodeType = .text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Chamada do método que configura o qr code baseado no tipo do qr e conecta no base
        qrCodeCardView.configure(with: cardTitle ?? "", qrCodeImage: generateQRCode(from: qrCodeText ?? ""), qrCodeTypeIcon: qrCodeType?.icon)
    }
}
