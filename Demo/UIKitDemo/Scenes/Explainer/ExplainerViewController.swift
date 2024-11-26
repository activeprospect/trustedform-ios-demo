import UIKit

final class ExplainerViewController: UIViewController {
    @IBOutlet private var sliderView: SliderView!
    @IBOutlet private var continueButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "EXPLAINER_NAV_TITLE".localized
        navigationItem.hidesBackButton = true
        continueButton.setTitle("EXPLAINER_CONTINUE_BUTTON".localized, for: .normal)

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "EXPLAINER_SKIP".localized, style: .plain, target: self, action: #selector(skip))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.1764705882, green: 0.8, blue: 0.4392156863, alpha: 1)
        setupSlides()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        continueButton.layer.cornerRadius = 4
    }

    @objc private func skip() {
        presentHome()
    }

    private func presentHome() {
        let viewController = BottomMenuViewController()
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }

    @IBAction private func `continue`() {
        presentHome()
    }

    private func setupSlides() {
        let slide1 = Slide(icon: #imageLiteral(resourceName: "explainer-1"), title: "EXPLAINER_1_TITLE".localized,
                           text: "EXPLAINER_1_TEXT".localized)
        let slide2 = Slide(icon: #imageLiteral(resourceName: "explainer-2"), title: "EXPLAINER_2_TITLE".localized,
                           text: "EXPLAINER_2_TEXT".localized)
        let slide3 = Slide(icon: #imageLiteral(resourceName: "explainer-3"), title: "EXPLAINER_3_TITLE".localized,
                           text: "EXPLAINER_3_TEXT".localized)
        sliderView.slides = [slide1, slide2, slide3]
    }
}
