//
//  QrCodeType.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 29/09/24.
//
import UIKit

enum StaticQRCodeType: CaseIterable, QRCodeTypeProtocol {
    case text
    case website
    case sms
    case vcard
    case wifi
    
    var title: String {
        switch self {
        case .text: return "Texto"
        case .website: return "Website"
        case .sms: return "SMS"
        case .vcard: return "vCard"
        case .wifi: return "Wifi"
            
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .sms: return UIImage(systemName: "message")
        case .text: return UIImage(systemName: "textformat")
        case .website: return UIImage(systemName: "globe")
        case .vcard: return UIImage(systemName: "person.crop.square.filled.and.at.rectangle")
        case .wifi: return UIImage(systemName: "wifi")
        }
    }
}
