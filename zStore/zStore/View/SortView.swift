//
//  SortView.swift
//  zStore
//
//  Created by Keerthika on 28/05/24.
//

import UIKit

import UIKit

protocol SortViewDelegate: AnyObject {
    func didSelectSortOption(_ option: String)
}

class SortView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView()
    var items = ["ratings", "amount"]
    var icons = ["shape-5", "shape-6"]
    var selectedIndexPath: IndexPath?
    weak var delegate: SortViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
        selectDefaultOption()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTableView()
        selectDefaultOption()
    }
    
    private func setupTableView() {
        addSubview(tableView)
        backgroundColor = UIColor.white
        
        tableView.backgroundColor = UIColor.lightGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func selectDefaultOption() {
        selectedIndexPath = IndexPath(row: 0, section: 0)
        tableView.reloadData()
        if delegate != nil {
            delegate?.didSelectSortOption(items[0])  
        }
    }
    
    // UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        let isSelected = indexPath == selectedIndexPath
        cell.configure(withTitle: items[indexPath.row], isSelected: isSelected, icon: icons[indexPath.row])
        return cell
    }
    
    // UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let previousIndexPath = selectedIndexPath, previousIndexPath != indexPath {
            // Unselect previous selected cell
            if let previousCell = tableView.cellForRow(at: previousIndexPath) as? CustomTableViewCell {
                previousCell.configure(withTitle: items[previousIndexPath.row], isSelected: false, icon: icons[previousIndexPath.row])
            }
        }
        
        // Select the new cell
        selectedIndexPath = indexPath
        if let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell {
            cell.configure(withTitle: items[indexPath.row], isSelected: true, icon: icons[indexPath.row])
        }
        
        if delegate != nil {
            delegate?.didSelectSortOption(items[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .lightGray
        
        let label = UILabel()
        label.text = "Sort Options"
        label.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(label)
        label.backgroundColor = UIColor.lightGray
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}

class CustomTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let radioButton = UIButton(type: .custom)
    let iconView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        // Configure titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        // Configure radioButton
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        radioButton.setImage(UIImage(systemName: "circle"), for: .normal)
        radioButton.setImage(UIImage(systemName: "largecircle.fill.circle"), for: .selected)
        radioButton.isUserInteractionEnabled = false
        
        contentView.addSubview(radioButton)
        
        // Configure iconView
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.image = UIImage(systemName: "arrow.right") // Placeholder icon
        
        contentView.addSubview(iconView)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            radioButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            radioButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            radioButton.widthAnchor.constraint(equalToConstant: 24),
            radioButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configure(withTitle title: String, isSelected: Bool, icon: String) {
        titleLabel.text = title
        radioButton.isSelected = isSelected
        iconView.image = UIImage(named: icon)
    }
}
