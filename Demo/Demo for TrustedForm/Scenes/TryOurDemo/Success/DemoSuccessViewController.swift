import UIKit

final class DemoSuccessViewController: UIViewController {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var infoTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        infoTextView.textContainerInset = .zero
        infoTextView.textContainer.lineFragmentPadding = 0

        navigationItem.title = "TRY_OUR_DEMO_SUCCESS_NAV_TITLE".localized
        titleLabel.textWithLineSpacing("TRY_OUR_DEMO_SUCCESS_TITLE".localized, lineHeight: 32)
        infoTextView.textWithLineSpacing("TRY_OUR_DEMO_SUCCESS_TEXT".localized, lineHeight: 18)
    }
}
