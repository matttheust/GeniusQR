//
//  ViewController.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 26/09/24.
//

import UIKit

class GenerateViewController: UIViewController {
    
    // MARK: - CONFIGS DA TELA
    let scrollView = UIScrollView()
    let contentView = UIView()
    let stackView = UIStackView()
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    // MARK: - UI CONFIGURATION
    func setupUI() {
        navigationItem.title = "Generate"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        stackView.axis = .vertical
        stackView.spacing = 32
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        
        createSection(title: "Estáticos", qrTypes: StaticQrCodeType.allCases)
        createSection(title: "Dinâmicos", qrTypes: DynamicQrCodeType.allCases, isDynamic: true)
    }
    
    // MARK: - SECTION CREATION
    func createSection<T>(title: String, qrTypes: [T], isDynamic: Bool = false) where T: QrCodeTypeProtocol {
        let sectionLabel = UILabel()
        sectionLabel.text = title
        sectionLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        sectionLabel.textColor = .label
        stackView.addArrangedSubview(sectionLabel)
        
        let horizontalStack = UIStackView()
        horizontalStack.axis = .vertical
        horizontalStack.spacing = 16
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        
        var rowStack: UIStackView? = nil
        
        for (index, qrType) in qrTypes.enumerated() {
            if index % 2 == 0 {
                rowStack = UIStackView()
                rowStack?.axis = .horizontal
                rowStack?.spacing = 16
                rowStack?.distribution = .fillEqually
                horizontalStack.addArrangedSubview(rowStack!)
            }
            
            let card = CardView()
            card.configure(withTitle: qrType.title, icon: qrType.icon)
            card.qrCodeType = qrType as? StaticQrCodeType
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cardTapped(_:)))
            card.addGestureRecognizer(tapGesture)
            card.isUserInteractionEnabled = !isDynamic
            
            if isDynamic {
                card.alpha = 0.5
                card.backgroundColor = UIColor.systemGray.withAlphaComponent(0.5)
            }
            
            rowStack?.addArrangedSubview(card)
        }
        
        if qrTypes.count % 2 != 0 {
            let placeholderView = UIView()
            placeholderView.widthAnchor.constraint(equalToConstant: 16).isActive = true
            rowStack?.addArrangedSubview(placeholderView)
        }
        
        stackView.addArrangedSubview(horizontalStack)
    }
    
    // MARK: - ACTIONS
    @objc func cardTapped(_ sender: UITapGestureRecognizer) {
        guard let card = sender.view as? CardView,
              let qrType = card.qrCodeType else { return } // Obtenha o tipo do card
        
        // Feedback visual ao tocar
        UIView.animate(withDuration: 0.2,
                       animations: {
            card.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                card.transform = .identity // Retorna ao tamanho original
            }
            
            // Navegando para a próxima tela após a animação
            let presentationVC: UIViewController
            
            switch qrType {
            case .text:
                presentationVC = TextQRCodeViewController()
            case .website:
                presentationVC = UrlQRCodeViewController()
            case .sms:
                presentationVC = SmsQRCodeViewController()
            case .vcard:
                presentationVC = VcardQRCodeViewController()
            case .wifi:
                presentationVC = WifiQRCodeViewController()
            }
            
            // Configurando a apresentação do view controller
            let navigationController = UINavigationController(rootViewController: presentationVC)
            // Adicionando ao UINavigationController
            navigationController.modalPresentationStyle = .automatic
            self.present(navigationController, animated: true, completion: nil)
        }
    }
}
