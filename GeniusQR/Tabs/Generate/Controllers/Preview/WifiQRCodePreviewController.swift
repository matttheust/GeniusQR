//
//  WifiQRCodePreviewViewController.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 08/10/24.
//

import UIKit

class WifiQRCodePreviewController: QRCodePreviewController {
    
    // Configura o preview com as informações da rede WiFi
    func configure(ssid: String, securityType: String, password: String?) {
        // Converte "Aberta" para "nopass" para compatibilidade
        // 'passwordString' será vazia se não houver senha definida ou se o tipo de segurança permitir acesso sem senha.

        let securityType = securityType == "Aberta" ? "nopass" : securityType
        let passwordString = securityType == "nopass" ? "" : (password ?? "")
        
        // Gera o texto do QR code no formato WiFi
        self.qrCodeText = "WIFI:S:\(ssid);T:\(securityType);P:\(passwordString);;"
        
        // Define apenas o SSID como título do card
        self.cardTitle = ssid
        
        // Define o tipo de QR Code como WiFi
        self.qrCodeType = .wifi
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Chamada do método que configura o qr code baseado no tipo do qr e conecta no base
        if let qrCodeType = qrCodeType {
            qrCodeCardView.configure(with: cardTitle ?? "", qrCodeImage: generateQRCode(from: qrCodeText ?? ""), qrCodeTypeIcon: qrCodeType.icon)
        }
    }
}
