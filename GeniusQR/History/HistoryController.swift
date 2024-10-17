//
//  ViewController.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 26/09/24.
//

import UIKit

class HistoryController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var qrCodes: [(image: UIImage, title: String, type: StaticQRCodeType)] = [] // Armazenando imagens, títulos e tipos
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadQRCodeFiles()  // Carregar os QR codes ao iniciar
    }

    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Histórico"

        setupTableView()  // Configuração da UITableView
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(QRCodeTableViewCell.self, forCellReuseIdentifier: QRCodeTableViewCell.identifier) // Registrando a célula personalizada
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadQRCodeFiles() // Carregar QR codes ao entrar na aba
    }
    
    func loadQRCodeFiles() {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!

        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
            qrCodes.removeAll() // Limpa a lista antes de carregar
            for fileURL in fileURLs {
                if let image = UIImage(contentsOfFile: fileURL.path) {
                    let title = fileURL.deletingPathExtension().lastPathComponent // Pega o nome do arquivo sem a extensão
                    
                    // Aqui você deve determinar o tipo do QR code
                    var type: StaticQRCodeType = .text // Default
                    let titleLowercased = title.lowercased() // Convertendo o título para minúsculas para comparação
                    
                    if titleLowercased.starts(with: "website_") {
                        type = .website // Define como Website
                    } else if titleLowercased.starts(with: "sms_") {
                        type = .sms // Define como SMS
                    } else if titleLowercased.starts(with: "vcard_") {
                        type = .vcard // Define como vCard
                    } else if titleLowercased.starts(with: "wifi_") {
                        type = .wifi // Define como Wifi
                    }
                    
                    // Debug: imprimir tipo e título
                    print("Adicionando QR Code - Título: \(title), Tipo: \(type)")
                    
                    qrCodes.append((image: image, title: title, type: type))
                }
            }
            tableView.reloadData()  // Atualizar a tabela com os QR codes
        } catch {
            print("Erro ao ler QR Codes: \(error)")
        }
    }
    
    // MARK: - UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qrCodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QRCodeTableViewCell.identifier, for: indexPath) as? QRCodeTableViewCell else {
            return UITableViewCell()
        }
        
        let qrCode = qrCodes[indexPath.row]
        let icon = qrCode.type.icon // Obtenha o ícone correspondente ao tipo
        
        print("Configurando célula - Título: \(qrCode.title), Tipo: \(qrCode.type), Ícone: \(String(describing: icon))") // Debug
        cell.configure(with: qrCode.title, icon: icon) // Passa o título original e o ícone
        return cell
    }
    
    // MARK: - UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedQRCode = qrCodes[indexPath.row]
        let detailVC = QRCodeHistoryDetailViewController()
        detailVC.qrCodeImage = selectedQRCode.image
        detailVC.qrCodeTitle = selectedQRCode.title
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // Implementando swipe para deletar
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let titleToDelete = qrCodes[indexPath.row].title
            qrCodes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            deleteQRCodeFile(named: titleToDelete)
        }
    }
    
    private func deleteQRCodeFile(named title: String) {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("\(title).png")

        do {
            try fileManager.removeItem(at: fileURL)
            print("QR Code deletado: \(fileURL)")
        } catch {
            print("Erro ao deletar QR Code: \(error)")
        }
    }
}
