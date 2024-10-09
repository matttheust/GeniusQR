//
//  QrCodeType.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 29/09/24.
//
import UIKit

enum DynamicQrCodeType: CaseIterable, QrCodeTypeProtocol {
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
