//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {

    var buttons: [UIButton]!
    let stackView = UIStackView()
    var stackViewHeightConstraint: NSLayoutConstraint!

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .yellow

        let topPlaceholder = UIView()
        topPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        topPlaceholder.heightAnchor.constraint(equalToConstant: 0).isActive = true

        let bottomPlaceholder = UIView()
        bottomPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        bottomPlaceholder.backgroundColor = .red
        bottomPlaceholder.heightAnchor.constraint(equalToConstant: 4).isActive = true


        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        let contentView = UIView()
        contentView.backgroundColor = .green
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        contentView.bound(inside: scrollView)
        view.addSubview(scrollView)
        scrollView.bound(inside: view)
        contentView.addSubview(stackView)

        stackView.addArrangedSubview(topPlaceholder)
        buttons = [1, 2, 3, 4, 5, 6, 7, 8].map(createButton)
        buttons.forEach {
            stackView.addArrangedSubview($0)
        }
        stackView.addArrangedSubview(bottomPlaceholder)

        let stackViewSize = stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        contentView.widthAnchor.constraint(equalToConstant: stackViewSize.width).isActive = true
        topPlaceholder.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bottomPlaceholder.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        self.view = view
    }

    @objc
    func toggleButtonVisibility(sender: UIButton) {
        if let buttonIndex = buttons?.firstIndex(of: sender) {
            UIView.animate(withDuration: 0.8) {
                self.stackView.arrangedSubviews[buttonIndex + 1].alpha = 0
                self.stackView.arrangedSubviews[buttonIndex + 1].isHidden = true
            }
        }
    }

    func createButton(number: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Stack view item \(number)", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 50)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textColor = .black
        button.isHidden = false
        button.backgroundColor = UIColor.green
        let height = CGFloat(100 + 10 * number)
        button.heightAnchor.constraint(equalToConstant: height).isActive = true
        button.addTarget(self, action: #selector(toggleButtonVisibility(sender:)), for: .touchUpInside)
        return button
    }

}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

extension UIView {
    func verticallyBound(inside other: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: other.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive = true
    }

    func horizontallyBound(inside other: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(equalTo: other.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: other.rightAnchor).isActive = true
    }

    func bound(inside other: UIView) {
        verticallyBound(inside: other)
        horizontallyBound(inside: other)
    }
}

