//
//  PlaceTypeListViewController.swift
//  First iOS App
//
//  Created by Ioannis Frontzos on 13/11/19.
//  Copyright © 2019 Ioannis Frontzos. All rights reserved.
//

import UIKit

protocol SendFilterProtocol {
    func setFilters()
}

class PlaceTypeListViewController: UITableViewController {
    
    var delegate: SendFilterProtocol?
    
    var types = [TypeView]()
    let cellIdentifier = "PlaceTypeFilterTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (type, isVisivle) in TypesFilter.shared.types {
            types.append(TypeView(type: type, isVisible: isVisivle))
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if types.count == 0 {
            return UITableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlaceTypeFilterTableViewCell  else {
            fatalError("The dequeued cell is not an instance of PlaceTypeFilterTableViewCell.")
        }
        
        let type = types[indexPath.row]
        cell.type.text = type.type
        cell.isVisible.isOn = type.isVisible
        cell.isVisible.tag = indexPath.row
        cell.isVisible.addTarget(self, action: #selector(onVisibilyChanged), for: UIControl.Event.valueChanged)
        
        return cell
    }
    
    @objc func onVisibilyChanged(toggle: UISwitch){
        let typeView = types[toggle.tag]
        types[toggle.tag].isVisible = toggle.isOn
        TypesFilter.shared.types.updateValue(toggle.isOn, forKey: typeView.type)
        delegate?.setFilters()
    }
}

struct TypeView: Hashable{
    let type: String
    var isVisible: Bool = true
}
