//
//  ViewController.swift
//  API TableView
//
//  Created by Семен Гевенов on 18.11.2024.
//

import SnapKit
import UIKit

class ViewController: UIViewController {

    // MARK: - Private properties
    private lazy var tableView = UITableView()
    private var incantationsData: [SpellsDatum] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
                    make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        // tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        
        APIManager.shared.getSpells { [weak self] values in
            DispatchQueue.main.async {
                guard let self else { return }
                self.incantationsData = values
                self.tableView.reloadData()
            }
        }
    }
}

    // MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 
        incantationsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell else {
            fatalError("Не удалось извлечь CustomTableViewCell")
        }
        
        let spell = incantationsData[indexPath.row]
        cell.configure(with: spell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "А правду говорят..."
        }
}

class CustomTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    private let nameLabel = UILabel()
    private let incantationLabel = UILabel()
    private let effectLabel = UILabel()
    private let typeLabel = UILabel()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        incantationLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        effectLabel.font = UIFont.systemFont(ofSize: 14)
        typeLabel.font = UIFont.systemFont(ofSize: 12)
        typeLabel.textColor = .secondaryLabel
        
       
        let stackView = UIStackView(arrangedSubviews: [nameLabel, incantationLabel, effectLabel, typeLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Configuration Method
    func configure(with spell: SpellsDatum) {
        nameLabel.text = "Название: \(spell.name)"
        incantationLabel.text = "Заклинание: \(spell.incantation ?? "Не указано")"
        effectLabel.text = "Эффект: \(spell.effect)"
        typeLabel.text = "Тип: \(spell.type)"
        
        if let canBeVerbal = spell.canBeVerbal {
                    contentView.backgroundColor = canBeVerbal ? UIColor.systemGreen.withAlphaComponent(0.2) : UIColor.systemRed.withAlphaComponent(0.2)
                } else {
                    contentView.backgroundColor = UIColor.systemGray.withAlphaComponent(0.2)
                }
    }
    
}
