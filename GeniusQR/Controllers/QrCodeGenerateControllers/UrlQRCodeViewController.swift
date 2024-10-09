//
//  UrlQRCodeViewController.swift
//  GeniusQR
//
//  Created by Matheus Torres on 30/09/24.
//

import UIKit

class UrlQRCodeViewController: UIViewController {
    
    private let stackView = UIStackView()
    private let titleTextField = UITextField() // Campo de título
    private let urlTextField = UITextField() // Campo de URL
    private let addButton = UIBarButtonItem()
    private let cancelButton = UIBarButtonItem()

    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        titleTextField.becomeFirstResponder() // Abre o teclado automaticamente no campo de título
    }

    // MARK: - UI CONFIGURATION
    private func setupUI() {
        view.backgroundColor = UIColor(white: 0.89, alpha: 1) // Cor de fundo off-white

        // Configurando o stackView
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        // Configurando o campo de título
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.borderStyle = .roundedRect
        titleTextField.placeholder = "Título"
        titleTextField.layer.cornerRadius = 10
        titleTextField.layer.masksToBounds = true
        stackView.addArrangedSubview(titleTextField)
        
        // Configurando o campo de URL
        urlTextField.translatesAutoresizingMaskIntoConstraints = false
        urlTextField.borderStyle = .roundedRect
        urlTextField.placeholder = "URL(deve iniciar com http:// ou https://)"
        urlTextField.delegate = self
        urlTextField.layer.cornerRadius = 10
        urlTextField.layer.masksToBounds = true
        stackView.addArrangedSubview(urlTextField)

        // Definindo as constraints do stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    private func setupNavigationBar() {
        navigationItem.title = "Novo QR Code - URL"

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
        guard let url = urlTextField.text, !url.isEmpty else { return }
        guard url.hasPrefix("http://") || url.hasPrefix("https://") else {
            showAlert("URL Inválido", "O link deve começar com http:// ou https://")
            return
        }
        
        let previewVC = UrlQRCodePreviewViewController()
        previewVC.configure(with: titleTextField.text ?? "", url: url)
        
        navigationController?.pushViewController(previewVC, animated: true)
    }

    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    private func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate
extension UrlQRCodeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Atualiza o botão "Adicionar" com base no texto
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        // Se o usuário está apagando (string é vazia), habilita o botão se o texto não estiver vazio
        if string.isEmpty {
            addButton.isEnabled = !updatedText.isEmpty
            return true // Permite a remoção
        }

        // Se não estiver apagando, altera a primeira letra para minúscula
        let firstCharacter = updatedText.prefix(1).lowercased()
        let remainingText = updatedText.dropFirst()
        let modifiedText = firstCharacter + remainingText

        // Atualiza o textField com o texto modificado
        textField.text = String(modifiedText)
        addButton.isEnabled = !modifiedText.isEmpty
        
        return false // Impede que o texto original seja adicionado
    }
}
