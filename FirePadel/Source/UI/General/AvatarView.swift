import UIKit
import Haneke

final class AvatarView: UIView {
    private let size: Size
    private let url: URL
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: Initialization
    
    init(size: Size, url: URL) {
        self.size = size
        self.url = url
        super.init(frame: CGRect(x: 0, y: 0, width: size.rawValue, height: size.rawValue))
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View setup
    
    private func setup() {
        addSubviews()
        roundCourners()
        setupConstraints()
        loadImage()
    }
    
    private func addSubviews() {
        addSubview(imageView)
        imageView.frame = bounds
    }
    
    private func roundCourners() {
        layer.cornerRadius = size.rawValue / 2
        layer.masksToBounds = true
    }
    
    private func loadImage() {
        imageView.hnk_setImageFromURL(url)
    }
    
    private func setupConstraints() {
        imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: size.rawValue, height: size.rawValue)
    }
    
    // MARK: Inner types
    
    enum Size: CGFloat {
        case standard = 40
        case small = 30
    }
}
