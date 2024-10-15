//
//  Untitled.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 30/09/24.
//

import UIKit

class SmsQRCodeController: UIViewController {

    private let stackView = UIStackView()
    private let phoneNumberTextField = UITextField()
    private let messageTextField = UITextField()
    private let addButton = UIBarButtonItem()
    private let cancelButton = UIBarButtonItem()

    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        
        // Abre o teclado automaticamente quando carrega a view
        phoneNumberTextField.becomeFirstResponder()
    }

    // MARK: - UI CONFIGURATION
    private func setupUI() {
        view.backgroundColor = UIColor(white: 0.89, alpha: 1)

        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        phoneNumberTextField.borderStyle = .roundedRect
        phoneNumberTextField.placeholder = "Ex: +55 11 91234-5678"
        phoneNumberTextField.delegate = self
        stackView.addArrangedSubview(phoneNumberTextField)

        messageTextField.borderStyle = .roundedRect
        messageTextField.placeholder = "Digite a mensagem"
        messageTextField.delegate = self
        stackView.addArrangedSubview(messageTextField)

        // Constraints da stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Novo QR Code - SMS"

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

    // MARK: - ACTIONS
    @objc private func addButtonTapped() {
        guard let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty,
              let message = messageTextField.text, !message.isEmpty else { return }
        
        // Validação do número de telefone no formato internacional
        if !isValidPhoneNumber(phoneNumber) {
            showAlert(message: "Por favor, insira um número de telefone válido no formato internacional.")
            return
        }
        
        // Extraindo DDD e número do telefone
        let formattedNumber = formatPhoneNumber(phoneNumber)
        let smsData = "sms:\(phoneNumber)&body=\(message)"
        let previewVC = SmsQRCodePreviewController()
        previewVC.configure(with: smsData)
        
        // Atualizar o título para "SMS - {DDD e número}"
        previewVC.cardTitle = "SMS - \(formattedNumber)"
        
        navigationController?.pushViewController(previewVC, animated: true)
    }

    private func formatPhoneNumber(_ phoneNumber: String) -> String {
        // Supondo que o número esteja no formato "+55 11 91234-5678"
        // Removendo o código do país
        let components = phoneNumber.split(separator: " ")
        
        // A primeira parte é o código do país, a segunda parte é o DDD e o restante é o número
        if components.count > 2 {
            let ddd = components[1] // DDD
            let number = components[2...] // O restante é o número
            return "\(ddd) \(number.joined(separator: " "))" // Formata como "DDD número"
        }
        
        return phoneNumber // Retornar como está se o formato for inesperado
    }

    private func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        // Expressão regular para validar números de telefone internacionais
        let phoneRegex = "^\\+\\d{1,3} \\d{1,4} \\d{4,10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return predicate.evaluate(with: phoneNumber)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate
extension SmsQRCodeController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        addButton.isEnabled = !updatedText.isEmpty
        return true
    }
}
