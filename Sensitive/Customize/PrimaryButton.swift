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


class PrimaryButton: UIView {
    // Content View
    @IBOutlet private weak var contentView: UIView!
    // Button
    @IBOutlet private weak var button: UIButton!
    // Button title
    @IBInspectable var title: String? {
        didSet {
            button.setTitle(title, for: .normal)
        }
    }

    // MARK: - Override Method
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    // MARK: - Private Method
    private func initView() {
        Bundle.main.loadNibNamed("PrimaryButton", owner: self, options: nil)
        addSubview(contentView)
        contentView
            .leftAnchor
            .constraint(equalTo: self.leftAnchor)
            .isActive = true
        contentView
            .topAnchor
            .constraint(equalTo: self.topAnchor)
            .isActive = true
        contentView
            .rightAnchor
            .constraint(equalTo: self.rightAnchor)
            .isActive = true
        contentView
            .bottomAnchor
            .constraint(equalTo: self.bottomAnchor)
            .isActive = true
        contentView
            .layer
            .cornerRadius = 12
        contentView.clipsToBounds = true
    }

    @IBAction private func touchUpInside(_ sender: Any) {
        touchUpInside?()
    }

    // MARK: - Public Method
    var touchUpInside: (() -> Void)?
}

