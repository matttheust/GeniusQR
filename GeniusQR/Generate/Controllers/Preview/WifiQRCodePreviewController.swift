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
        
        // Gera a imagem do QR code
        let qrCodeImage = generateQRCode(from: qrCodeText ?? "")
        
        // Configura a visualização do QR code
        qrCodeCardView.configure(with: cardTitle ?? "", qrCodeImage: qrCodeImage, qrCodeTypeIcon: qrCodeType?.icon)
        
        // Salvar QR Code gerado com o SSID do usuário
        if let image = qrCodeImage, let ssid = cardTitle {
            // Formata o nome do arquivo usando o padrão
            let filename = "wifi_\(ssid.replacingOccurrences(of: " ", with: "_")).png" // Substitui espaços por underscores
            saveQRCode(image: image, title: filename) // Salvar com o padrão de nomenclatura
        }
    }

    private func saveQRCode(image: UIImage, title: String) {
        guard let data = image.pngData() else { return }
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(title) // Usar o título como nome do arquivo

        do {
            try data.write(to: fileURL)
            print("QR Code salvo em: \(fileURL)")
        } catch {
            print("Erro ao salvar QR Code: \(error)")
        }
    }
}
