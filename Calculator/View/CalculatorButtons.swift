import UIKit

final class CalculatorButtons : UIButton {
    
    enum ButtonBgColor {
        case grey
        case blue
        case orange
    }
    
    private let bgColor : ButtonBgColor
    private let text : String
    
    init(withColor bgColor: ButtonBgColor, withText text : String) {
        self.bgColor = bgColor
        self.text = text
        super.init(frame: .zero)
         configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setTitle(text, for: .normal)
        setTitleColor(UIColor.white, for: .normal)
        switch bgColor {
        case .grey : backgroundColor = .specialLightGray
        case .blue : backgroundColor = .specialLightBlue
        case.orange : backgroundColor = .specialOrange
        }
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
    
    
}
