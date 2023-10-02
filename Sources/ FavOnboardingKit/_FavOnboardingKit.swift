// The Swift Programming Language
// https://docs.swift.org/swift-book
import UIKit
public protocol FavOnboardingKitDelegate: AnyObject {
    func nextButtonDidTap(atIndex index: Int)
    func getStartedButtonDidTap()
}
public class FavOnboardingKit {
    
    private let slides: [Slide]
    private let tintColor: UIColor
    public weak var delegate: FavOnboardingKitDelegate?
    
    private lazy var onboardingViewController: OnboardingViewController = {
        let controller = OnboardingViewController(slides: slides, tintColor: tintColor)
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .fullScreen
        controller.nextBtnDidTap = { [weak self] index in
            guard let self = self else { return }
            self.delegate?.nextButtonDidTap(atIndex: index)
        }
        controller.getStartedBtnDidTap = { [weak self] in
            guard let self = self else { return }
            self.delegate?.getStartedButtonDidTap()
        }
        return controller
    }()
    
    public init(slides: [Slide], tintColor: UIColor) {
        self.slides = slides
        self.tintColor = tintColor
    }
    
    public func launchOnboarding(rootVC: UIViewController) {
        rootVC.present(onboardingViewController, animated: true)
    }
    
    public func dismissOnboarding() {
        
    }
    
}
