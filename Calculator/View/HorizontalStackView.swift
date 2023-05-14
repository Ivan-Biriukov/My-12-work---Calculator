import UIKit

final class HorizontalStackView : UIStackView {
    
    private let stackView : UIStackView
    
    init(stackView: UIStackView) {
        self.stackView = stackView
        super.init(frame: .zero)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .clear
        axis = .horizontal
        distribution = .fillEqually
        spacing = 1
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
