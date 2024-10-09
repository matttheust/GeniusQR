//
//  ViewController.swift
//  GeniusQR
//
//  Created by Matheus  Torres on 26/09/24.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Settings"
        navigationItem.largeTitleDisplayMode = .always
        
        
        setupUI()
    }

    func setupUI() {
        let label = UILabel()
        label.text = "Settings"
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
