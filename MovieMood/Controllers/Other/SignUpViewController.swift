import UIKit

/// This class opens when user wants to register a new acc
final class SignUpViewController: UIViewController {
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.text = "Sign Up"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let completeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = "Complete your account"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "back-button-icon"),
                                  for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let signUpButton = BlueButton(withStyle: .signUp)
    
    private let emailTextField = AuthTextField(forStyle: .email)
    private let firstNameTextField = AuthTextField(forStyle: .firstName)
    private let lastNameTextField = AuthTextField(forStyle: .lastName)
    private let passwordTextField = AuthTextField(forStyle: .password)
    private let confirmPasswordTextField = AuthTextField(forStyle: .confirmPassword)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .custom.mainBackground
        setupView()
    }
}

extension SignUpViewController {
    private func setupView() {
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10
            )
        ])
        
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.heightAnchor.constraint(equalToConstant: 48),
            backButton.widthAnchor.constraint(equalToConstant: 48),
            backButton.centerYAnchor.constraint(
                equalTo: titleLabel.centerYAnchor
            ),
            backButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 24
            )
        ])
        
        view.addSubview(completeLabel)
        NSLayoutConstraint.activate([
            completeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            completeLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor, constant: 43
            )
        ])
        
        view.addSubview(subLabel)
        NSLayoutConstraint.activate([
            subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subLabel.topAnchor.constraint(equalTo: completeLabel.bottomAnchor, constant: 8)
        ])
        
        let stack = UIStackView(arrangedSubviews: [
            emailTextField, firstNameTextField, lastNameTextField,
            passwordTextField, confirmPasswordTextField, signUpButton
        ])
        stack.axis = .vertical
        stack.spacing = 25
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(
                lessThanOrEqualTo: completeLabel.bottomAnchor, constant: 120
            ),
            stack.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10
            ),
            stack.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 24
            ),
            stack.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -24
            )
        ])
    }
}
