//
//  TextQRCodePreviewViewController.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 08/10/24.
//

import UIKit

class UrlQRCodePreviewController: QRCodePreviewController {
    
    private var urlData: String?
    
    // Método para configurar o controller com a URL e o título
    func configure(with url: String) {
        self.urlData = url
        self.cardTitle = url // O título será o domínio da URL
        self.qrCodeType = .website // Define o tipo como website
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Chamada do método que configura o qr code baseado no tipo do qr e conecta no base
        let qrCodeImage = generateQRCode(from: urlData ?? "")
        qrCodeCardView.configure(with: cardTitle ?? "", qrCodeImage: qrCodeImage, qrCodeTypeIcon: qrCodeType?.icon)
        
        // Salvar QR Code gerado com o domínio
        if let image = qrCodeImage, let url = urlData {
            // Remove o prefixo http:// ou https:// e cria o nome do arquivo
            let filename = "website_\(url.replacingOccurrences(of: "http://", with: "").replacingOccurrences(of: "https://", with: "").replacingOccurrences(of: "/", with: "_").replacingOccurrences(of: " ", with: "_")).png"
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
