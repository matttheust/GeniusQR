//
//  UrlQRCodeViewController.swift
//  GeniusQR
//
//  Created by Matheus Torres on 30/09/24.
//

import UIKit

class UrlQRCodeController: UIViewController {
    
    private let stackView = UIStackView()
    private let titleTextField = UITextField()
    private let urlTextField = UITextField()
    private let addButton = UIBarButtonItem()
    private let cancelButton = UIBarButtonItem()

    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        
        // Abre o teclado automaticamente no campo de título
        titleTextField.becomeFirstResponder()
    }

    // MARK: - UI CONFIGURATION
    private func setupUI() {
        
        // Cor de fundo off-white
        view.backgroundColor = UIColor(white: 0.89, alpha: 1)

        // StackView
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.borderStyle = .roundedRect
        titleTextField.placeholder = "Ex: Google.com"
        titleTextField.layer.cornerRadius = 10
        titleTextField.layer.masksToBounds = true
        stackView.addArrangedSubview(titleTextField)

        
        urlTextField.translatesAutoresizingMaskIntoConstraints = false
        urlTextField.borderStyle = .roundedRect
        urlTextField.placeholder = "URL(deve iniciar com http:// ou https://)"
        urlTextField.delegate = self
        urlTextField.layer.cornerRadius = 10
        urlTextField.layer.masksToBounds = true
        stackView.addArrangedSubview(urlTextField)

        // Constraints da stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    private func setupNavigationBar() {
        navigationItem.title = "Novo QR Code - Website"

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
        
        // Validações
        guard url.hasPrefix("http://") || url.hasPrefix("https://") else {
            showAlert("URL Inválido", "O link deve começar com http:// ou https://")
            return
        }
        
        let previewVC = UrlQRCodePreviewController()
        previewVC.configure(with: url) 
        
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

// MARK: - UITextFieldDelegate - Hacking with swift
extension UrlQRCodeController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Atualiza o botão "Adicionar" com base no texto
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        // Se o usuário está apagando (string é vazia), habilita o botão se o texto não estiver vazio
        if string.isEmpty {
            addButton.isEnabled = !updatedText.isEmpty
            // Permite a remoção
            return true
        }

        // Se não estiver apagando, altera a primeira letra para minúscula
        let firstCharacter = updatedText.prefix(1).lowercased()
        let remainingText = updatedText.dropFirst()
        let modifiedText = firstCharacter + remainingText

        // Atualiza o textField com o texto modificado
        textField.text = String(modifiedText)
        addButton.isEnabled = !modifiedText.isEmpty
        
        // Impede que o texto original seja adicionado
        return false
    }
}
