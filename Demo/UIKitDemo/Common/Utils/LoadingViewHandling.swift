import UIKit

protocol LoadingViewHandling: UIViewController {
    var loadingView: UIView? { get }
    
    func setLoadingViewVisibility(_ shouldShow: Bool, shouldAnimate: Bool)
}

extension LoadingViewHandling {
    func setLoadingViewVisibility(_ shouldShow: Bool, shouldAnimate: Bool = true) {
        if shouldAnimate {
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                self?.loadingView?.alpha = shouldShow ? 1 : 0
            }) { [weak self] _ in
                self?.loadingView?.isHidden = !shouldShow
            }
        } else {
            loadingView?.isHidden = !shouldShow
        }
    }
}

