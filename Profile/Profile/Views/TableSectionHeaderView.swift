//
//  TableSectionHeaderView.swift
//  Profile
//
//  Created by Artem Kufaev on 28.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit
import UI

@IBDesignable
class TableSectionHeaderView: UIView {
    
    @IBInspectable
    var title: String? {
        didSet {
            titleLabel?.text = title
        }
    }
    
    private var titleLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
        setupTitleLabel()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
        setupTitleLabel()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configure()
        setupTitleLabel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.frame = makeTitleLabelFrame()
    }
    
    private func setupTitleLabel() {
        titleLabel = UILabel(frame: makeTitleLabelFrame())
        titleLabel?.text = title
        titleLabel?.font = Font.MontserratBold.of(size: 18)
        addSubview(titleLabel!)
    }
    
    private func makeTitleLabelFrame() -> CGRect {
        return CGRect(x: 20, y: 0,
                      width: frame.width,
                      height: frame.height)
    }
    
    private func configure() {
        backgroundColor = .white
    }
    
}
