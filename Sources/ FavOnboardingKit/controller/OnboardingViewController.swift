//
//  OnboardingViewController.swift
//
//
//  Created by mohamed ahmed on 02/10/2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    var nextBtnDidTap: ((Int)  -> Void)?
    var getStartedBtnDidTap: (()  -> Void)?
    
    private let slides: [Slide]
    private let tintColor: UIColor
    
    private lazy var transationView: TransationView = {
        let view = TransationView(slides: slides, tintColor: tintColor)
        return view
    }()
    
    private lazy var bottomContainerView: BottomContainerView = {
        let view = BottomContainerView(tintColor: tintColor)
        view.nextBtnDidTap = {[weak self] in
            guard let self = self else { return }
            self.nextBtnDidTap?(self.transationView.slideIndex)
            self.transationView.handleTap(dirction: .right)
        }
        view.getStartedBtnDidTap = getStartedBtnDidTap
        return view
    }()
    
    private lazy var stackView: UIStackView = {
       let view = UIStackView(arrangedSubviews: [transationView, bottomContainerView])
        view.axis = .vertical
        return view
    }()
    
     init(slides: [Slide], tintColor: UIColor) {
        self.slides = slides
        self.tintColor = tintColor
         super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        transationView.start()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        
        bottomContainerView.snp.makeConstraints { make in
            make.height.equalTo(120)
        }
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap(_:)))
        transationView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func viewDidTap(_ tap: UITapGestureRecognizer) {
        let point = tap.location(in: view)
        let midPoint = view.frame.width / 2
        if point.x > midPoint {
            transationView.handleTap(dirction: .right)
        } else {
            transationView.handleTap(dirction: .left)
        }
    }
}
