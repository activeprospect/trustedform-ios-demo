//

import UIKit
import TrustedFormSwift

class AdvertiserSuggestionViewController: UIViewController {
    private let baseSubmissionId = "advertiser-suggestion-screen"
    var certificate: Certificate? = nil

    let advertisers: [String] = [
        "Advertiser A",
        "Advertiser B",
        "Advertiser C",
        "Advertiser D",
        "Advertiser E",
    ]

    @IBOutlet var advertiserLabels: [UILabel]!
    @IBOutlet var submitButtons: [UIButton]!
    @IBOutlet weak var consentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureElementRoles()
    }

    //MARK: IBActions
    @IBAction func advertiserTapped(_ button: UIButton) {
        guard button.isSelected == false else { return }
        button.isSelected = true
    }

    @IBAction func stopTrackingTapped(_ sender: Any) {
        guard let certificate else { return }
        TrustedForm.default.stopTracking(for: certificate)
    }

    //MARK: Private
    private func configureUI() {
        configureSubmitButtons()
        configureAdvertiserLabels()
    }

    private func configureSubmitButtons() {
        submitButtons.forEach { button in
            var configuration = UIButton.Configuration.plain()
            configuration.title = "Get Info"
            configuration.image = nil
            button.configuration = configuration
            button.configurationUpdateHandler = { button in
                button.handleConfigurationUpdate()
            }
        }
    }

    private func configureAdvertiserLabels() {
        for (index, label) in advertiserLabels.enumerated() {
            guard advertisers.indices.contains(index) else { return }
            label.text = "\(advertisers[index]) can help you with this decision."
        }
    }

    private func configureElementRoles() {
        // Labels
        for (index, label) in advertiserLabels.enumerated() {
            label.tfElementRole = .consentTrackedText(
                submissionId: "\(baseSubmissionId)-\(index)",
                label: advertisers[index]
            )
        }

        // Submit Buttons
        for (index, button) in submitButtons.enumerated() {
            guard advertisers.indices.contains(index) else { return }
            button.tfElementRole = .submit(
                submissionId: "\(baseSubmissionId)-\(index)",
                label: "Get Info",
                index: index
            )
        }

        //Consent Text
        consentLabel.tfElementRole = .consentLanguage(submissionId: baseSubmissionId)
    }
}

private extension UIButton {
    func handleConfigurationUpdate() {
        switch state {
        case .normal:
            configuration?.title = "Get Info"
            configuration?.image = nil
        case .selected:
            configuration?.title = "Get Info"
            configuration?.image = UIImage(systemName: "checkmark.square")
//            configuration?.title = nil
//            backgroundColor = nil
        case .highlighted, .disabled, .focused:
            configuration?.title = "Get Info"
        default:
            configuration?.title = "Get Info"
        }
    }
}
