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
        let qrCodeImage = generateQRCode(from: vCardData ?? "")
        qrCodeCardView.configure(with: cardTitle ?? "", qrCodeImage: qrCodeImage, qrCodeTypeIcon: qrCodeType?.icon)
        
        // Salvar QR Code gerado com o título do usuário
        if let image = qrCodeImage, let title = vCardTitle {
            // Remove espaços e cria o nome do arquivo
            let filename = "vcard_\(title.replacingOccurrences(of: " ", with: "_")).png" // Nome do arquivo ajustado
            saveQRCode(image: image, title: filename) // Salvar usando o padrão de nomenclatura
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
