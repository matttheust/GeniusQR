//
//  QrCodeType.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 29/09/24.
//
import UIKit

enum DynamicQRCodeType: CaseIterable, QRCodeTypeProtocol {
    case links
    case email
    
    var title: String {
        switch self {
        case .links: return "Links"
        case .email: return "Email"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .links: return UIImage(systemName: "link")
        case .email: return UIImage(systemName: "envelope")
        }
    }
}
