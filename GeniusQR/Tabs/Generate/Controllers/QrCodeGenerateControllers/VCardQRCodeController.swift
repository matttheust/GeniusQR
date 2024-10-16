//
//  VCardQRCodeViewController.swift
//  GeniusQR
//
//  Created by Matheus Torres on 30/09/24.
//

import UIKit

class VCardQRCodeController: UIViewController, UITextFieldDelegate {

    // MARK: - UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()
    private let firstNameTextField = UITextField()
    private let lastNameTextField = UITextField()
    private let mobileTextField = UITextField()
    private let phoneTextField = UITextField()
    private let faxTextField = UITextField()
    private let emailTextField = UITextField()
    private let companyTextField = UITextField()
    private let streetTextField = UITextField()
    private let cityTextField = UITextField()
    private let zipTextField = UITextField()
    private let stateTextField = UITextField()
    private let countryTextField = UITextField()
    private let websiteTextField = UITextField()
    private let addButton = UIBarButtonItem()
    private let cancelButton = UIBarButtonItem()

    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        
        // Verifica se os campos estão preenchidos
        checkIfFieldsAreFilled()
    }

    // MARK: - UI CONFIGURATION
    private func setupUI() {
        
        // Cor de fundo off-white
        view.backgroundColor = UIColor(white: 0.89, alpha: 1)

        // scrollView
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        // contentView
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        // stackView
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)

        // Tupla para placeholders
        let textFields: [(String, UITextField)] = [
            ("Digite seu primeiro nome", firstNameTextField),
            ("Digite seu sobrenome", lastNameTextField),
            ("Digite seu número de celular", mobileTextField),
            ("Digite seu telefone", phoneTextField),
            ("Digite seu fax", faxTextField),
            ("Digite seu e-mail", emailTextField),
            ("Digite o nome da empresa", companyTextField),
            ("Digite o endereço", streetTextField),
            ("Digite a cidade", cityTextField),
            ("Digite o CEP", zipTextField),
            ("Digite o estado", stateTextField),
            ("Digite o país", countryTextField),
            ("Digite o seu website", websiteTextField)
        ]

        for (placeholder, textField) in textFields {
            
            //define os placeholders
            textField.placeholder = placeholder
            textField.borderStyle = .roundedRect
            
            //A propria classe vai lidar com eventos de edição
            textField.delegate = self
            textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
            
            stackView.addArrangedSubview(textField)
        }

        // constraints da scrollView e contentView
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

    private func setupNavigationBar() {
        navigationItem.title = "Novo QR Code - vCard"

        // Botão "Adicionar" - inicialmente desabilitado
        addButton.title = "Adicionar"
        addButton.style = .done
        addButton.target = self
        addButton.action = #selector(addButtonTapped)
        addButton.isEnabled = false
        navigationItem.rightBarButtonItem = addButton

        // Botão "Cancelar"
        cancelButton.title = "Cancelar"
        cancelButton.style = .done
        cancelButton.target = self
        cancelButton.action = #selector(cancelButtonTapped)
        cancelButton.tintColor = .systemRed
        navigationItem.leftBarButtonItem = cancelButton
    }

    // MARK: - ACTIONS
    @objc private func addButtonTapped() {
        let vCardString = """
        BEGIN:VCARD
        VERSION:3.0
        N:\(lastNameTextField.text ?? " ");\(firstNameTextField.text ?? " ")
        TEL;TYPE=CELL:\(mobileTextField.text ?? "")
        TEL;TYPE=WORK:\(phoneTextField.text ?? "")
        TEL;TYPE=FAX:\(faxTextField.text ?? "")
        EMAIL:\(emailTextField.text ?? "")
        ORG:\(companyTextField.text ?? "")
        ADR;TYPE=WORK:;;\(streetTextField.text ?? "");\(cityTextField.text ?? "");\(stateTextField.text ?? "");\(zipTextField.text ?? "");\(countryTextField.text ?? "")
        URL:\(websiteTextField.text ?? "")
        END:VCARD
        """
        
        // Pega o nome e sobrenome para o título
        let fullName = "\(firstNameTextField.text ?? "") \(lastNameTextField.text ?? "")"
        
        let previewVC = VCardQRCodePreviewController()
        
        // Passa o título junto com a string vCard
        previewVC.configure(with: vCardString, title: fullName)
        
        navigationController?.pushViewController(previewVC, animated: true)
    }

    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func textFieldChanged() {
        checkIfFieldsAreFilled()
    }

    private func checkIfFieldsAreFilled() {
        // Verifica se todos os campos de texto estão preenchidos
        let allFieldsFilled = !firstNameTextField.text!.isEmpty &&
                              !lastNameTextField.text!.isEmpty &&
                              !mobileTextField.text!.isEmpty &&
                              !phoneTextField.text!.isEmpty &&
                              !faxTextField.text!.isEmpty &&
                              !emailTextField.text!.isEmpty &&
                              !companyTextField.text!.isEmpty &&
                              !streetTextField.text!.isEmpty &&
                              !cityTextField.text!.isEmpty &&
                              !zipTextField.text!.isEmpty &&
                              !stateTextField.text!.isEmpty &&
                              !countryTextField.text!.isEmpty &&
                              !websiteTextField.text!.isEmpty
        addButton.isEnabled = allFieldsFilled // Habilita e/ou desabilita o botão "Adicionar"
    }
}
