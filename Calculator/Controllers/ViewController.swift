
import UIKit

class ViewController: UIViewController {
    
    private var isFinishTypingNumber : Bool = true
    private var calculator = CalculateLogicModel()
    
    private var displayValue : Double {
        get {
            guard let number = Double(label.text!) else {
                fatalError("Cannot convert displayLabel text to a Double")
            }
            return number
        }
        set {
            label.text = String(newValue)
        }
    }
    
    
    // MARK: - Creating UI
    
    private let mainStackView : UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .clear
        stack.axis = .vertical
        stack.spacing = 1
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var label : UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.textAlignment = .right
        lb.text = "0"
        lb.backgroundColor = .specialLightGray
        lb.font = UIFont.systemFont(ofSize: 50)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let firstLaneStack = HorizontalStackView(stackView: UIStackView())
    private let acButton = CalculatorButtons(withColor: .grey, withText: "AC")
    private let plusminusButton = CalculatorButtons(withColor: .grey, withText: "+/-")
    private let percentButton = CalculatorButtons(withColor: .grey, withText: "%")
    private let devideButton = CalculatorButtons(withColor: .orange, withText: "÷")
    
    private let secondLaneStack = HorizontalStackView(stackView: UIStackView())
    private let sevenButton = CalculatorButtons(withColor: .blue, withText: "7")
    private let eightButton = CalculatorButtons(withColor: .blue, withText: "8")
    private let nineButton = CalculatorButtons(withColor: .blue, withText: "9")
    private let multiplyButton = CalculatorButtons(withColor: .orange, withText: "×")
    
    private let thirdLaneStack = HorizontalStackView(stackView: UIStackView())
    private let fourButton = CalculatorButtons(withColor: .blue, withText: "4")
    private let fiveButton = CalculatorButtons(withColor: .blue, withText: "5")
    private let sixButton = CalculatorButtons(withColor: .blue, withText: "6")
    private let minusButton = CalculatorButtons(withColor: .orange, withText: "-")
    
    private let fourthLaneStack = HorizontalStackView(stackView: UIStackView())
    private let oneButton = CalculatorButtons(withColor: .blue, withText: "1")
    private let twoButton = CalculatorButtons(withColor: .blue, withText: "2")
    private let threeButton = CalculatorButtons(withColor: .blue, withText: "3")
    private let plusButton = CalculatorButtons(withColor: .orange, withText: "+")
    
    private let lasLaneStack = HorizontalStackView(stackView: UIStackView())
    private let zeroButton = CalculatorButtons(withColor: .blue, withText: "0")
    private let lastLaneIncludeButtonStack = HorizontalStackView(stackView: UIStackView())
    private let commaButton = CalculatorButtons(withColor: .blue, withText: ".")
    private let equalButton = CalculatorButtons(withColor: .orange, withText: "=")
    
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        addNumButtonsTargets()
        addOperationButtonsTargets()
    }
    
    // MARK: - Buttons Methods
    
    @objc func numButtonTaped(_ sender: UIButton){
        if let numValue = sender.currentTitle {
            if isFinishTypingNumber {
                label.text = numValue
                isFinishTypingNumber = !isFinishTypingNumber
            } else {
                if numValue == "."{
                    let isInt = floor(displayValue) == displayValue
                    
                    if !isInt {
                        return
                    }
                }
                label.text! += numValue
            }
        }
    }
    
    @objc func operationButtonTaped (_ sender : UIButton) {
        isFinishTypingNumber = !isFinishTypingNumber
        calculator.setNumber(displayValue)
        if let calcMethod = sender.currentTitle {
            if  let result = calculator.calculate(symbol: calcMethod) {
                displayValue = result
            }
        }
    }

    
    // MARK: - Configure UI
    
    private func addSubviews() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(label)
        mainStackView.addArrangedSubview(firstLaneStack)
        mainStackView.addArrangedSubview(secondLaneStack)
        mainStackView.addArrangedSubview(thirdLaneStack)
        mainStackView.addArrangedSubview(fourthLaneStack)
        mainStackView.addArrangedSubview(lasLaneStack)
        
        firstLaneStack.addArrangedSubview(acButton)
        firstLaneStack.addArrangedSubview(plusminusButton)
        firstLaneStack.addArrangedSubview(percentButton)
        firstLaneStack.addArrangedSubview(devideButton)
        
        secondLaneStack.addArrangedSubview(sevenButton)
        secondLaneStack.addArrangedSubview(eightButton)
        secondLaneStack.addArrangedSubview(nineButton)
        secondLaneStack.addArrangedSubview(multiplyButton)
        
        thirdLaneStack.addArrangedSubview(fourButton)
        thirdLaneStack.addArrangedSubview(fiveButton)
        thirdLaneStack.addArrangedSubview(sixButton)
        thirdLaneStack.addArrangedSubview(minusButton)
        
        fourthLaneStack.addArrangedSubview(oneButton)
        fourthLaneStack.addArrangedSubview(twoButton)
        fourthLaneStack.addArrangedSubview(threeButton)
        fourthLaneStack.addArrangedSubview(plusButton)
        
        lasLaneStack.addArrangedSubview(zeroButton)
        lasLaneStack.addArrangedSubview(lastLaneIncludeButtonStack)
        lastLaneIncludeButtonStack.addArrangedSubview(commaButton)
        lastLaneIncludeButtonStack.addArrangedSubview(equalButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    // MARK: - addTargetToButtons
    
    private func addNumButtonsTargets() {
        let buttonsArray = [ sevenButton, eightButton, nineButton, fourButton, fiveButton, sixButton, oneButton, twoButton, threeButton, zeroButton, commaButton]
        for button in buttonsArray {
            button.addTarget(self, action: #selector(numButtonTaped), for: .touchUpInside)
        }
    }
    
    private func addOperationButtonsTargets() {
        let buttonsArray = [acButton, plusminusButton, percentButton, devideButton, multiplyButton,   minusButton, plusButton, equalButton]
        for button in buttonsArray {
            button.addTarget(self, action: #selector(operationButtonTaped), for: .touchUpInside)
        }
        
    }
}

