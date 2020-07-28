//
//  ProfileMenuSwitchCell.swift
//  Profile
//
//  Created by Artem Kufaev on 28.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit
import UI

class ProfileMenuSwitchCell: UITableViewCell, ConfigurableCell {

    typealias ViewModel = (title: String, isEnable: Bool)
    
    static var reuseIdentifier: String {
        return "ProfileMenuSwitchCell"
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    
    var onSwitch: ((Bool) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupSwitch()
    }
    
    private func setupSwitch() {
        self.switch.onTintColor = UIColor.ThemeColors.brandBlueColor
        self.switch.addTarget(self, action: #selector(onSwitchEvent), for: .valueChanged)
    }
    
    func configure(_ viewModel: (title: String, isEnable: Bool), at indexPath: IndexPath) {
        titleLabel.text = viewModel.title
        self.switch.setOn(viewModel.isEnable, animated: true)
    }
    
    @objc func onSwitchEvent() {
        onSwitch?(self.switch.isOn)
    }
    
}
