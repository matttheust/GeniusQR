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
            // Formatar o nome do arquivo seguindo o padrão
            let filename = "text_\(title.replacingOccurrences(of: " ", with: "_"))" // Substitui espaços por underscores
            saveQRCode(image: image, title: "\(filename).png") // Salvar com o padrão de nomenclatura
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
