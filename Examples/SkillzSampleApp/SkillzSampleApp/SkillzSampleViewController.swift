#if canImport(UIKit)
import UIKit
import Skillz

final class SkillzSampleViewController: UIViewController {
    private let statusLabel = UILabel()
    private let launchButton = UIButton(type: .system)

    private let gameId: String
    private let environment: SkillzEnvironment
    private var isInitialized = false

    init(gameId: String, environment: SkillzEnvironment) {
        self.gameId = gameId
        self.environment = environment
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureStatusLabel()
        configureLaunchButton()
    }

    private func configureStatusLabel() {
        statusLabel.text = "Skillz SDK not initialized yet."
        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 0
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statusLabel)
    }

    private func configureLaunchButton() {
        launchButton.setTitle("Launch Skillz", for: .normal)
        launchButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        launchButton.addTarget(self, action: #selector(launchSkillzTapped), for: .touchUpInside)
        launchButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(launchButton)

        NSLayoutConstraint.activate([
            statusLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),

            launchButton.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 24),
            launchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc private func launchSkillzTapped() {
        initializeIfNeeded()
        emitStatus("Launching Skillz…")
        Skillz.skillzInstance().launch()
    }

    private func initializeIfNeeded() {
        guard !isInitialized else { return }
        let gameIdString = String(gameId)
        Skillz.skillzInstance().initWithGameId(gameIdString,
                                               for: self,
                                               with: environment,
                                               allowExit: true)
        isInitialized = true
        emitStatus("Skillz SDK initialized.")
    }

    private func emitStatus(_ message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.statusLabel.text = message
        }
    }
}

extension SkillzSampleViewController: SkillzDelegate {
    func tournamentWillBegin(_ gameParameters: [AnyHashable : Any], with matchInfo: SKZMatchInfo) {
        let name = matchInfo.name
        emitStatus("Tournament \(name) starting…")
    }

    func preferredSkillzInterfaceOrientation() -> SkillzOrientation {
        return .portrait
    }

    func skillzWillLaunch() {
        emitStatus("Skillz lobby will appear…")
    }

    func skillzHasFinishedLaunching() {
        emitStatus("Skillz lobby is now active.")
    }

    func skillzWillExit() {
        emitStatus("Returning from Skillz lobby.")
    }
}
#endif
