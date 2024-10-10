//
//  Untitled.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 30/09/24.
//

import UIKit

class TextQRCodeController: UIViewController {

    private let stackView = UIStackView()
    private let textField = UITextField()
    private let addButton = UIBarButtonItem()
    private let cancelButton = UIBarButtonItem()

    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        textField.becomeFirstResponder() // Abre o teclado automaticamente quando carrega a view
    }

    // MARK: - UI CONFIGURATION
    private func setupUI() {
        view.backgroundColor = UIColor(white: 0.89, alpha: 1) // Cor de fundo off-white

        // Adicionando o campo de texto diretamente à view
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Digite o texto aqui"
        textField.delegate = self
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        view.addSubview(textField)

        // Definindo as constraints do textField
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Novo QR Code - Texto"

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
        guard let text = textField.text, !text.isEmpty else { return }
        
        let previewVC = TextQRCodePreviewController()
        previewVC.configure(with: text)
        
        navigationController?.pushViewController(previewVC, animated: true)
    }

    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate
extension TextQRCodeController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Atualiza o botão "Adicionar" com base no texto
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        addButton.isEnabled = !updatedText.isEmpty // Habilita o botão apenas se o campo não estiver vazio
        return true
    }
}
