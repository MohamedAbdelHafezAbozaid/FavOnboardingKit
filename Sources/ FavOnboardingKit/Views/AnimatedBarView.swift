//
//  AnimatedBarView.swift
//
//
//  Created by mohamed ahmed on 02/10/2023.
//

import UIKit
import Combine

class AnimatedBarView: UIView {
    
    enum State {
        case clear
        case animating
        case filled
    }
    
    private lazy var backGroundBarView: UIView = {
        let view = UIView()
        view.backgroundColor = barColor.withAlphaComponent(0.2)
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var foregroundBarView: UIView = {
        let view = UIView()
        view.backgroundColor = barColor
        view.alpha = 0.0
        return view
    }()
    
    @Published private var state: State = .clear
    private var cancellables = Set<AnyCancellable>()
    private var animator: UIViewPropertyAnimator!
    private let barColor: UIColor
    
     init(barColor: UIColor) {
         self.barColor = barColor
         super.init(frame: .zero)
         setupAnimator()
         layout()
         observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAnimator() {
        animator = UIViewPropertyAnimator(
            duration: 3.0,
            curve: .easeInOut,
            animations: {
            self.foregroundBarView.transform = .identity
        })
    }
    
    private func observe() {
        $state
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .clear:
                    setupAnimator()
                    foregroundBarView.alpha = 0.0
                    animator.stopAnimation(false)
                case .animating:
                    foregroundBarView.transform = .init(scaleX: 0, y: 1.0)
                    foregroundBarView.transform = .init(translationX: -frame.size.width, y: 0)
                    foregroundBarView.alpha = 1.0
                    animator.startAnimation()
                case .filled:
                    animator.stopAnimation(true)
                    foregroundBarView.transform = .identity
                }
            }.store(in: &cancellables)
    }
    
    private func layout() {
         addSubview(backGroundBarView)
        backGroundBarView.addSubview(foregroundBarView)
        backGroundBarView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        foregroundBarView.snp.makeConstraints { make in
            make.edges.equalTo(backGroundBarView)
        }
    }
    
    func startAnimating() {
        state = .animating
    }
    
    func reset() {
        state = .clear
    }
    
    func complete() {
        state = .filled
    }
}
