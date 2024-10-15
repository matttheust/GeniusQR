//
//  ViewController.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 26/09/24.
//


//MARK: - EM CONSTRUÇÃO
import UIKit

class HistoryController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "History"
        navigationItem.largeTitleDisplayMode = .always
        
        
        setupUI()
    }

    func setupUI() {
        let label = UILabel()
        label.text = "QR Code History"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
