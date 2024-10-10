//
//  Untitled.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 30/09/24.
//

import UIKit

class WifiQRCodeController: UIViewController {
    
    // MARK: - Properties
    private let stackView = UIStackView()
    private let securityView = UIView()
    private let securityLabel = UILabel()
    private let encryptionButton = UIButton(type: .system)
    private let ssidTextField = UITextField()
    private let passwordTextField = UITextField()
    
    private let encryptionOptions = ["WPA/WPA2", "WEP", "Aberta"]
    private var selectedEncryption = "WPA/WPA2"
    
    private let addButton = UIBarButtonItem()
    private let cancelButton = UIBarButtonItem()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        ssidTextField.becomeFirstResponder()
    }
    
    // MARK: - UI Configuration
    private func setupUI() {
        view.backgroundColor = .systemGroupedBackground
        
        // Stack View
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        // Tipo de Segurança - Security View
        securityView.translatesAutoresizingMaskIntoConstraints = false
        securityView.backgroundColor = .systemBackground
        securityView.layer.cornerRadius = 5
        securityView.layer.borderWidth = 1
        securityView.layer.borderColor = UIColor.systemGray5.cgColor
        
        stackView.addArrangedSubview(securityView)
        
        // Label Tipo de Segurança
        securityLabel.text = "Tipo de Segurança"
        securityLabel.font = .systemFont(ofSize: 17)
        securityLabel.textColor = .label
        securityLabel.translatesAutoresizingMaskIntoConstraints = false
        securityView.addSubview(securityLabel)
        
        // Encryption Button com UIMenu
        var configuration = UIButton.Configuration.plain()
        configuration.title = selectedEncryption
        configuration.image = UIImage(systemName: "chevron.up.chevron.down")
        configuration.imagePadding = 8
        configuration.baseForegroundColor = .systemGray

        encryptionButton.configuration = configuration
        encryptionButton.semanticContentAttribute = .forceRightToLeft
        encryptionButton.showsMenuAsPrimaryAction = true
        encryptionButton.menu = createEncryptionMenu()
        encryptionButton.translatesAutoresizingMaskIntoConstraints = false

        securityView.addSubview(encryptionButton)
        
        // SSID TextField
        ssidTextField.translatesAutoresizingMaskIntoConstraints = false
        ssidTextField.backgroundColor = .systemBackground
        ssidTextField.borderStyle = .roundedRect
        ssidTextField.placeholder = "Nome da rede (SSID)"
        ssidTextField.delegate = self
        ssidTextField.clearButtonMode = .whileEditing
        stackView.addArrangedSubview(ssidTextField)
        
        // Password TextField
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.backgroundColor = .systemBackground
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "Senha"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        passwordTextField.clearButtonMode = .whileEditing
        stackView.addArrangedSubview(passwordTextField)
        
        // Constraints
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // Security View Constraints
            securityView.heightAnchor.constraint(equalToConstant: 44),
            
            // Label Tipo de Segurança
            securityLabel.centerYAnchor.constraint(equalTo: securityView.centerYAnchor),
            securityLabel.leadingAnchor.constraint(equalTo: securityView.leadingAnchor, constant: 8),
            
            // Encryption Button
            encryptionButton.centerYAnchor.constraint(equalTo: securityView.centerYAnchor),
            encryptionButton.trailingAnchor.constraint(equalTo: securityView.trailingAnchor, constant: -8)
        ])
        
        updatePasswordFieldState()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Novo QR Code - WiFi"
        
        addButton.title = "Adicionar"
        addButton.style = .done
        addButton.target = self
        addButton.action = #selector(addButtonTapped)
        addButton.isEnabled = false
        navigationItem.rightBarButtonItem = addButton
        
        cancelButton.title = "Cancelar"
        cancelButton.style = .done
        cancelButton.target = self
        cancelButton.action = #selector(cancelButtonTapped)
        cancelButton.tintColor = .systemRed
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    // MARK: - Helpers
    private func createEncryptionMenu() -> UIMenu {
        return UIMenu(title: "", children: encryptionOptions.map { option in
            UIAction(title: option, state: option == selectedEncryption ? .on : .off, handler: { _ in
                self.selectedEncryption = option
                self.encryptionButton.setTitle(option, for: .normal)
                self.updatePasswordFieldState()
            })
        })
    }
    
    private func updatePasswordFieldState() {
        let isOpenNetwork = selectedEncryption == "Aberta"
        passwordTextField.isHidden = isOpenNetwork
    }
    
    // MARK: - Actions
    @objc private func addButtonTapped() {
        guard let ssid = ssidTextField.text, !ssid.isEmpty else { return }
        let password = passwordTextField.text ?? ""
        
        let previewVC = WifiQRCodePreviewController()
        previewVC.configure(ssid: ssid,
                           securityType: selectedEncryption,
                           password: password)
        
        navigationController?.pushViewController(previewVC, animated: true)
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate
extension WifiQRCodeController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Habilita o botão Adicionar apenas se o SSID não estiver vazio
        let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        if textField == ssidTextField {
            addButton.isEnabled = !updatedText.isEmpty
        }
        return true
    }
}
