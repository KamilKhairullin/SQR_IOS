import UIKit

protocol LoginSucceed {
    func loginSucceed(on viewController: UIViewController, with token: String)
}

class LoginViewController: UIViewController {

    public var appCoordinator: AppCoordinator?
    private var networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Logo")
        iv.contentMode = .scaleAspectFill

        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let usernameInputField: UITextField = {
        let iv = UITextField()
        iv.backgroundColor = ColorPalette.customWhite
        iv.textColor = ColorPalette.customBlack
        iv.tintColor = .systemPurple
        iv.font = .systemFont(ofSize: 24)
        iv.textAlignment = .center

        iv.placeholder = "Username"

        iv.layer.cornerRadius = 12.5

        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let passwordInputField: UITextField = {
        let iv = UITextField()
        iv.backgroundColor = ColorPalette.customWhite
        iv.textColor = ColorPalette.customBlack
        iv.tintColor = .systemPurple
        iv.font = .systemFont(ofSize: 24)
        iv.textAlignment = .center

        iv.placeholder = "Password"

        iv.layer.cornerRadius = 12.5

        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    lazy var loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = ColorPalette.customYellow
        btn.setTitle("Login", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 24)
        btn.setTitleColor(UIColor.black, for: .normal)

        btn.layer.cornerRadius = 12.5
        btn.layer.shadowColor = UIColor.systemGray.cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        btn.layer.shadowOpacity = 1.0
        btn.layer.shadowRadius = 2.5
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 12.5

        btn.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    let qrImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "qr")
        iv.contentMode = .scaleAspectFill

        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    // MARK: - - lifecycle, override

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        usernameInputField.text = ""
        usernameInputField.placeholder = "Username"
        passwordInputField.text = ""
        passwordInputField.placeholder = "Password"

        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = ColorPalette.customYellow

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    // MARK: - - objc

    @objc private func loginButtonClicked() {
        guard let username = usernameInputField.text,
              let password = passwordInputField.text
        else { return }

        let isUsernameCorrect = checkUsername(username: username)
        let isPasswordCorrect = checkPassword(password: password)

        if !isUsernameCorrect || !isPasswordCorrect {
            if !isUsernameCorrect {
                incorrectUsernameFormat()
                usernameInputField.text = ""
                usernameInputField.placeholder = "Incorrect format"
            }
            if !isPasswordCorrect {
                incorrectPasswordFormat()
                passwordInputField.text = ""
                passwordInputField.placeholder = "Incorrect format"
            }
        } else {
            let userDTO = UserDTO(login: username, password: password)

            networkService.login(credentials: userDTO) { [weak self] response in
                guard let self = self else { return }
                switch response {
                case let .success(data):
                    UserDefaults.standard.set(username, forKey: "username")
                    UserDefaults.standard.set(password, forKey: "password")
                    self.appCoordinator?.loginSucceed(on: self, with: data.token)
                case let .failure(error):
                    self.usernameInputField.text = ""
                    self.usernameInputField.placeholder = "Failed to login. Try agin"
                    self.passwordInputField.text = ""
                    self.passwordInputField.placeholder = "Failed to login. Try agin"
                    print(error.rawValue)
                }
            }
        }
    }

    // MARK: - - func

    private func setupViews() {
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -192)
        ])

        view.addSubview(usernameInputField)
        NSLayoutConstraint.activate([
            usernameInputField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 96),
            usernameInputField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            usernameInputField.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -32
            ),
            usernameInputField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameInputField.heightAnchor.constraint(equalToConstant: 48)
        ])

        view.addSubview(passwordInputField)
        NSLayoutConstraint.activate([
            passwordInputField.topAnchor.constraint(equalTo: usernameInputField.bottomAnchor, constant: 16),
            passwordInputField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            passwordInputField.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -32
            ),
            passwordInputField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordInputField.heightAnchor.constraint(equalToConstant: 48)
        ])

        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordInputField.bottomAnchor, constant: 64),
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 48)
        ])

    }

    private func checkUsername(username: String) -> Bool {
        if username == "" {
            return false
        }

        return true
    }

    private func checkPassword(password: String) -> Bool {
        if password == "" {
            return false
        }

        return true
    }

    private func incorrectUsernameFormat() {
        print("Incorrect username format")
    }

    private func incorrectPasswordFormat() {
        print("Incorrect password format")
    }

}

#if DEBUG
extension LoginViewController {
    public func exposPrivateLoginButtonClicked() {
        return loginButtonClicked()
    }
}
#endif
