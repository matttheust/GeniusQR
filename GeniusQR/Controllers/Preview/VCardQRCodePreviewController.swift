//
//  QRCodePreviewViewController.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 09/10/24.
//

import UIKit

class VCardQRCodePreviewController: QRCodePreviewController {

    private var vCardData: String?
    private var vCardTitle: String?

    func configure(with vCardData: String, title: String) {
        self.vCardData = vCardData
        self.vCardTitle = title
        self.cardTitle = vCardTitle ?? "vCard" // Se não houver título, use "vCard"
        self.qrCodeType = .vcard
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Chamada do método que configura o qr code baseado no tipo do qr e conecta no base
        qrCodeCardView.configure(with: cardTitle ?? "", qrCodeImage: generateQRCode(from: vCardData ?? ""), qrCodeTypeIcon: qrCodeType?.icon)
    }
}
