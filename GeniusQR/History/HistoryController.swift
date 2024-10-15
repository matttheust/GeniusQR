//
//  ViewController.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 26/09/24.
//

import UIKit

class HistoryController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var qrCodes: [(image: UIImage, title: String)] = [] // Armazenando imagens e títulos
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
                    qrCodes.append((image: image, title: title))
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
        cell.configure(with: qrCode.image, title: qrCode.title)
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
            // Remove o QR code da lista e do diretório
            let titleToDelete = qrCodes[indexPath.row].title
            qrCodes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // Deletar o arquivo do diretório
            deleteQRCodeFile(named: titleToDelete)
        }
    }
    
    private func deleteQRCodeFile(named title: String) {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("\(title).png") // Construindo o caminho do arquivo

        do {
            try fileManager.removeItem(at: fileURL) // Tentando remover o arquivo
            print("QR Code deletado: \(fileURL)")
        } catch {
            print("Erro ao deletar QR Code: \(error)")
        }
    }
}
