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

        if let image = qrCodeImage, let components = smsData?.split(separator: ":").map(String.init), components.count > 1 {
            // Captura a parte que contém o número de telefone
            let phoneAndBody = components[1].trimmingCharacters(in: .whitespaces) // Ex: "+55 11 123123123&body=123123123123"

            // Divide para capturar apenas o número, removendo a parte do corpo
            let phoneNumberComponents = phoneAndBody.split(separator: "&").map(String.init)
            let formattedNumber = phoneNumberComponents[0].trimmingCharacters(in: .whitespaces) // Ex: "+55 11 123123123"
            
            // Gera o nome do arquivo, mantendo o '+'
            let filename = "sms_\(formattedNumber).png" // Nome do arquivo ajustado
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
