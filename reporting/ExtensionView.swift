//
//  ExtensionView.swift
//  reporting
//
//  Created by Michael Ong on 9/4/22.
//

import IdentityLookup
import UIKit
import YokongCommon

class ExtensionView: UIScrollView {
  weak var formReportMessage: FormReportMessage?

  override init(frame: CGRect) {
    super.init(frame: frame)

    contentInsetAdjustmentBehavior = .always
    backgroundColor = .systemBackground

    contentInset = .init(top: 16, left: 16, bottom: 32, right: 16)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError()
  }

  func prepareForMessage(_ request: ILMessageClassificationRequest) {
    formReportMessage = addSubviewAndPrepare(FormReportMessage(frame: .zero), preparation: { form in

      form.fieldSMSNumber.fieldView.text = request.messageCommunications[0].sender ?? ""

      NSLayoutConstraint.activate(form.layout(around: self), form.layout(widthsOf: self, inset: 32))
    })
  }

  func prepareForCall(_: ILCallClassificationRequest) {}
}
