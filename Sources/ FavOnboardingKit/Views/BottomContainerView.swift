//
//  BottomContainerView.swift
//
//
//  Created by mohamed ahmed on 02/10/2023.
//

import UIKit
import SnapKit

class BottomContainerView: UIView {
    
    var nextBtnDidTap: (() -> Void)?
    var getStartedBtnDidTap: (() -> Void)?
    
    private lazy var nexBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Next", for: .normal)
        btn.layer.borderColor = viewTintColor.cgColor
        btn.layer.borderWidth = 2
        btn.setTitleColor(viewTintColor, for: .normal)
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(nextBtnTap), for: .touchUpInside)
        return btn
    }()
    
    private lazy var getStartedBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Get Started", for: .normal)
        btn.backgroundColor = viewTintColor
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(getStartedBtnTap), for: .touchUpInside)
        return btn
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nexBtn, getStartedBtn])
        stackView.axis = .horizontal
        stackView.spacing = 24
        return stackView
    }()
    
    private let viewTintColor: UIColor
    
    init(tintColor: UIColor) {
        self.viewTintColor = tintColor
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 24, left: 24, bottom: 36, right: 24))
        }
        nexBtn.snp.makeConstraints { make in
            make.width.equalTo(getStartedBtn.snp.width).multipliedBy(0.5)
        }
    }
    
    @objc private func nextBtnTap() {
        nextBtnDidTap?()
    }
    
    @objc private func getStartedBtnTap() {
        getStartedBtnDidTap?()
    }
}
