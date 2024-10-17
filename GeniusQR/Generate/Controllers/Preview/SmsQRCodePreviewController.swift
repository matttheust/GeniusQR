//
//  TextQRCodePreviewViewController.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 08/10/24.
//

import UIKit

class SmsQRCodePreviewController: QRCodePreviewController {
    
    private var smsData: String?
    
    func configure(with smsData: String) {
        self.smsData = smsData
        let components = smsData.split(separator: ":").map(String.init) // Exemplo: "1234567890:Mensagem"
        
        if let number = components.first {
            self.cardTitle = "SMS \(number)" // Formatação do título
        }
        
        self.qrCodeType = .sms
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let qrCodeImage = generateQRCode(from: smsData ?? "")
        qrCodeCardView.configure(with: cardTitle ?? "", qrCodeImage: qrCodeImage, qrCodeTypeIcon: qrCodeType?.icon)

        // Salvar QR Code gerado com o título
        if let image = qrCodeImage, let components = smsData?.split(separator: ":").map(String.init), let number = components.first {
            let formattedNumber = number.trimmingCharacters(in: .whitespaces) // Remove espaços, se houver
            let filename = "\(formattedNumber).png" // Nome do arquivo ajustado para incluir apenas o número
            saveQRCode(image: image, title: filename) // Salvar usando o nome correto
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
