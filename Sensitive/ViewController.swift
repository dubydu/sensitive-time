/*
  Copyright © 2022 DUBYDU

  This software is provided 'as-is', without any express or implied warranty.
  In no event will the authors be held liable for any damages arising from
  the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
  claim that you wrote the original software. If you use this software in a
  product, an acknowledgment in the product documentation would be
  appreciated but is not required.

  2. Altered source versions must be plainly marked as such, and must not be
  misrepresented as being the original software.

  3. This notice may not be removed or altered from any source distribution.
 */

import UIKit

class ViewController: UIViewController {
    // Menu Stack View
    @IBOutlet private weak var menuStackView: UIStackView!
    // Notify Button
    @IBOutlet private weak var notifyButton: PrimaryButton!
    // Shortcuts Button
    @IBOutlet private weak var shortcutsButton: PrimaryButton!
    // Center Indicator
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    // App Delegate
    private var appDelegate = UIApplication
        .shared
        .delegate as? AppDelegate

    // MARK: - Override Method
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup UI
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard isViewLoaded else {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.indicator.stopAnimating()
            self.menuStackView.isHidden = false
        }
    }

    // MARK: - Private Method
    private func setupUI() {
        notifyButton.touchUpInside = { [weak self] in
            guard let self = self else {
                return
            }
            self.showAlertViewController()
        }
        shortcutsButton.touchUpInside = { [weak self] in
            guard let self = self else {
                return
            }
        }
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(processIntent),
                         name: Notification.Name("intent"),
                         object: nil
            )
    }

    @objc func processIntent() {
        print("============Process intent============")
    }
}

extension ViewController {
    // Show local notification alert
    private func showAlertViewController() {
        let notificationType = "Local Notification"
        let alert = UIAlertController(
            title: "\(notificationType) will appear after 10 seconds.",
            message: "",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "OK",
            style: .default
        ) { (_) in
            self.appDelegate?.scheduleNotification(notificationType)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
