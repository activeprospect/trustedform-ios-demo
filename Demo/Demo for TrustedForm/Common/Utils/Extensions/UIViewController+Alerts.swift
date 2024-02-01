import UIKit

extension UIViewController {
    func displayAlert(title: String?, message: String, actions: [UIAlertAction] = [UIAlertAction(title: "OK", style: .default)]) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        
        present(alert, animated: true)
    }
    
    func displayErrorAlert(title: String? = "ERROR_TITLE".localized, message: String) {
        displayAlert(title: title, message: message)
    }
}
