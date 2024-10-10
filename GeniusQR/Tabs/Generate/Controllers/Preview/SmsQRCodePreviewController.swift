//
//  TextQRCodePreviewViewController.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 08/10/24.
//

import UIKit

class SmsQRCodePreviewController: QRCodePreviewController {
    
    // Variável para armazenar os dados do SMS
    private var smsData: String?
    
    // Método para configurar o controller com os dados do SMS
    func configure(with smsData: String) {
        self.smsData = smsData
        self.cardTitle = "SMS"
        self.qrCodeType = .sms
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Chamada do método configure
        qrCodeCardView.configure(with: cardTitle ?? "", qrCodeImage: generateQRCode(from: smsData ?? ""), qrCodeTypeIcon: qrCodeType?.icon)
    }
}
