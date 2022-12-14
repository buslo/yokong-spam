//
//  RootController.swift
//  yokongspam
//
//  Created by Michael Ong on 9/4/22.
//

import UIKit
import YokongAppCommon

class RootController: UIViewController {
  let scrollView = UIScrollView()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .systemBackground

    view.addSubviewAndPrepare(scrollView) { scrollView in
      scrollView.contentInsetAdjustmentBehavior = .always
      scrollView.contentInset = .init(top: 16, left: 16, bottom: 16, right: 16)

      scrollView.addSubviewAndPrepare(FormReportMessage(frame: .zero)) { form in
        NSLayoutConstraint.activate(
          form.layout(around: scrollView),
          form.layout(widthsOf: view.safeAreaLayoutGuide, inset: 32)
        )
      }

      NSLayoutConstraint.activate(scrollView.layout(around: view, priorities: [.bottom: .defaultLow]), [
        scrollView.bottomAnchor.constraint(lessThanOrEqualTo: view.keyboardLayoutGuide.topAnchor),
      ])
    }
  }
}
