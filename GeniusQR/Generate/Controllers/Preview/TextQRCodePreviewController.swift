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
        self.cardTitle = text // Certifique-se de que isso é o que o usuário está passando
        self.qrCodeType = .text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Chamada do método que configura o qr code baseado no tipo do qr e conecta no base
        let qrCodeImage = generateQRCode(from: qrCodeText ?? "")
        qrCodeCardView.configure(with: cardTitle ?? "", qrCodeImage: qrCodeImage, qrCodeTypeIcon: qrCodeType?.icon)
        
        // Salvar QR Code gerado com o título do usuário
        if let image = qrCodeImage, let title = cardTitle {
            saveQRCode(image: image, title: title) // Salvar com título ao invés de nome de arquivo
        }
    }
    
    private func saveQRCode(image: UIImage, title: String) {
        guard let data = image.pngData() else { return }
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("\(title).png") // Usar o título como nome do arquivo

        do {
            try data.write(to: fileURL)
            print("QR Code salvo em: \(fileURL)")
        } catch {
            print("Erro ao salvar QR Code: \(error)")
        }
    }
}
