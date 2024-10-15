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
        
        // Cor de fundo off-white
        view.backgroundColor = UIColor(white: 0.89, alpha: 1)

        // StackView para organizar os campos
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

        // Botão "Adicionar" - inicialmente desabilitado
        addButton.title = "Adicionar"
        addButton.style = .done
        addButton.target = self
        addButton.action = #selector(addButtonTapped)
        addButton.isEnabled = false
        navigationItem.rightBarButtonItem = addButton

        // Botão "Cancelar" - estilo done -> Consistência
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
        
        let smsData = "sms:\(phoneNumber)&body=\(message)"
        let previewVC = SmsQRCodePreviewController()
        previewVC.configure(with: smsData)
        
        navigationController?.pushViewController(previewVC, animated: true)
    }

    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate
extension SmsQRCodeController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Atualiza o botão "Adicionar" com base no texto
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        // Habilita o botão apenas se o campo não estiver vazio
        addButton.isEnabled = !updatedText.isEmpty
        return true
    }
}
