//
//  ViewController.swift
//  API TableView
//
//  Created by Семен Гевенов on 18.11.2024.
//

import SnapKit
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        // tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "сell")  // Регистрируем ячейку в таблицеt
        
        APIManager.shared.getSpells { [weak self] values in
            DispatchQueue.main.async {
                guard let self else { return }
                self.incantationsData = values
                self.tableView.reloadData()
            }
        }
    }

    
    // MARK: - Private properties
    private var tableView = UITableView()
    private var incantationsData: [String] = []

}

    // MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {  // Количество ячеек в каждой секции
        incantationsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        let textValue = incantationsData[indexPath.row]
        cell.textLabel?.text = "\(textValue)"
        return cell
    }
}
