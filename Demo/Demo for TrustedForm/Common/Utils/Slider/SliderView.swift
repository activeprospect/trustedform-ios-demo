import UIKit

final class SliderView: UIView {
    var slides: [Slide] = [] {
        didSet {
            slidesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            setupSlides(slides: slides)
        }
    }

    @IBOutlet private var slidesStackView: UIStackView!
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var pageControl: UIPageControl!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var textLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("SliderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        scrollView.delegate = self
    }

    private func setupSlides(slides: [Slide]) {
        for index in 0 ..< slides.count {
            let slide = slides[index]
            
            let wrapperView = UIView()
            wrapperView.translatesAutoresizingMaskIntoConstraints = false
            slidesStackView.addArrangedSubview(wrapperView)
            wrapperView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor).isActive = true
            
            let imageView = UIImageView(image: slide.icon)
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            wrapperView.addSubview(imageView)
            imageView.widthAnchor.constraint(equalTo: wrapperView.widthAnchor, multiplier: 0.7).isActive = true
            imageView.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor).isActive = true
            imageView.centerYAnchor.constraint(equalTo: wrapperView.centerYAnchor).isActive = true
        }
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPage = 0
        pageControl.numberOfPages = slides.count
        if let slide = slides.first {
            updateLabels(title: slide.title, text: slide.text)
        }
    }

    private func updateLabels(title: String, text: String) {
        UIView.transition(with: titleLabel, duration: 0.2, options: .transitionCrossDissolve, animations: { [weak self] in
            self?.titleLabel.textWithLineSpacing(title, lineHeight: 30)
        })
        UIView.transition(with: textLabel, duration: 0.2, options: .transitionCrossDissolve, animations: { [weak self] in
            self?.textLabel.textWithLineSpacing(text, lineHeight: 21)
        })
    }
}

extension SliderView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let width = scrollView.bounds.size.width
        let currentPage = Int(x/width)
        if pageControl.currentPage != currentPage {
            pageControl.currentPage = currentPage
            let slide = slides[currentPage]
            updateLabels(title: slide.title, text: slide.text)
        }
    }
}
