import Foundation
import UIKit

protocol StartTheRoom {
    func startTheRoom(on viewCOntroller: UIViewController)
}

class CreateRoomController: UIViewController {

    var appCoordinator: AppCoordinator?
    var networkService: NetworkService

    init(coordinator: AppCoordinator?, networkService: NetworkService) {
        appCoordinator = coordinator
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let idLabel: UILabel = {
        let l = UILabel()
        l.text = "ID:"
        l.font = .systemFont(ofSize: 56)
        l.textColor = ColorPalette.customYellow

        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    let roomIdLabel: UILabel = {
        let l = UILabel()
        l.text = "loading"
        l.font = .systemFont(ofSize: 36)
        l.textColor = ColorPalette.customWhite

        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    let qrImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "qr")
        iv.contentMode = .scaleAspectFill

        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let partyLabel: UILabel = {
        let l = UILabel()
        l.text = "Party:"
        l.font = .systemFont(ofSize: 36)
        l.textColor = ColorPalette.customYellow

        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    let amountLabel: UILabel = {
        let l = UILabel()
        l.text = "loading"
        l.font = .systemFont(ofSize: 36)
        l.textColor = ColorPalette.customWhite

        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    lazy var startButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = ColorPalette.customYellow
        btn.setTitle("Start", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 24)
        btn.setTitleColor(UIColor.black, for: .normal)

        btn.layer.cornerRadius = 12.5
        btn.layer.shadowColor = UIColor.systemGray.cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        btn.layer.shadowOpacity = 1.0
        btn.layer.shadowRadius = 2.5
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 12.5

        btn.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    // MARK: - - lifecycle, override

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        setupViews()

        createARoom()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = ColorPalette.customYellow
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    // MARK: - - objc

    @objc private func startButtonClicked() {
        if let appCoordinator = appCoordinator {
            appCoordinator.startTheRoom(on: self)
        }
    }

    // MARK: - - func

    private func setupViews() {

        view.addSubview(idLabel)
        view.addSubview(roomIdLabel)
        NSLayoutConstraint.activate([
            idLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 56),
            idLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -128),

            roomIdLabel.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor),
            roomIdLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -56),
            roomIdLabel.bottomAnchor.constraint(equalTo: idLabel.bottomAnchor)
        ])

        view.addSubview(partyLabel)
        view.addSubview(amountLabel)
        NSLayoutConstraint.activate([
            partyLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 56),
            partyLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 32),

            amountLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -56),
            amountLabel.topAnchor.constraint(equalTo: partyLabel.topAnchor)
        ])

        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -64),
            startButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            startButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 48)
        ])

    }

    public func createARoom() {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""

        networkService.createRoom(token: token) { [weak self] response in
            switch response {
            case let .success(roomDTO):
                UserDefaults.standard.set(roomDTO.id, forKey: "roomId")
                UserDefaults.standard.set(roomDTO.slug, forKey: "roomSlug")

                self?.roomIdLabel.text = roomDTO.slug
                self?.amountLabel.text = String(roomDTO.users.count)
            case let .failure(error):
                print(error.rawValue)
            }
        }
    }
}
