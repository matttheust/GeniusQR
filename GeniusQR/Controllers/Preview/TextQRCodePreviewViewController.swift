//
//  TextQRCodePreviewViewController.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 08/10/24.
//

import UIKit

class TextQRCodePreviewViewController: QRCodePreviewViewController {
    
    func configure(with text: String) {
        self.qrCodeText = text
        self.cardTitle = text
        self.qrCodeType = .text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Chamada do método configure
        qrCodeCardView.configure(with: cardTitle ?? "", qrCodeImage: generateQRCode(from: qrCodeText ?? ""), qrCodeTypeIcon: qrCodeType?.icon)
    }
}
