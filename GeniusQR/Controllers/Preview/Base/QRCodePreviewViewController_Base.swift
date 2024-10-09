//
//  QRCodePreviewViewController.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 30/09/24.
//

import UIKit
import CoreImage.CIFilterBuiltins

class QRCodePreviewViewController: UIViewController {
    
    public let qrCodeCardView = QRCodeCardView()
    
    var qrCodeText: String?
    var cardTitle: String?
    var qrCodeType: StaticQrCodeType?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        
        if let text = qrCodeText, let title = cardTitle {
            DispatchQueue.main.async { [weak self] in
                let qrCodeImage = self?.generateQRCode(from: text)
                self?.qrCodeCardView.configure(with: title, qrCodeImage: qrCodeImage, qrCodeTypeIcon: self?.qrCodeType?.icon)
            }
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        qrCodeCardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(qrCodeCardView)
        
        NSLayoutConstraint.activate([
            qrCodeCardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            qrCodeCardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            qrCodeCardView.widthAnchor.constraint(equalToConstant: 300),
            qrCodeCardView.heightAnchor.constraint(equalToConstant: 350)
        ])
    }
    
    private func setupNavigationBar() {
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareQRCode))
        navigationItem.rightBarButtonItem = shareButton
    }
    
    public func generateQRCode(from string: String) -> UIImage? {
        let data = Data(string.utf8)
        let filter = CIFilter.qrCodeGenerator()
        filter.setValue(data, forKey: "inputMessage")
        
        if let qrCodeImage = filter.outputImage {
            let transformedImage = qrCodeImage.transformed(by: CGAffineTransform(scaleX: 10, y: 10))
            if let cgImage = CIContext().createCGImage(transformedImage, from: transformedImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        
        return nil
    }
    
    @objc private func shareQRCode() {
        guard let qrCodeImage = qrCodeCardView.qrCodeImageView.image else {
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems: [qrCodeImage], applicationActivities: nil)
        activityViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(activityViewController, animated: true, completion: nil)
    }
}


