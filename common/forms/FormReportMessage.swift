//
//  FormReportMessage.swift
//  common
//
//  Created by Michael Ong on 9/4/22.
//

import Foundation
import UIKit

public class FormReportMessage: UIView {
  weak var contentView: ComponentGroup!

  public weak var fieldSMSNumber: ComponentField!
  public weak var fieldSomethingField: ComponentField!

  override public init(frame: CGRect) {
    super.init(frame: frame)

    contentView = addSubviewAndPrepare(ComponentGroup.vertical) { group in
      group.withSpacing(12).withArrangedSubviews {
        prepareView(view: UILabel()) { label in
          label.font = .fontWithVariant(for: .heading3)
          label.text = "Report Message"
        }
        prepareView(ref: &fieldSMSNumber, view: ComponentField()) { field in
          field.labelView.text = "SMS Number"
        }
        prepareView(ref: &fieldSomethingField, view: ComponentField()) { field in
          field.labelView.text = "Test Field 1"
        }
      }

      NSLayoutConstraint.activate(group.layout(around: self))
    }
  }

  @available(*, unavailable)
  public required init?(coder _: NSCoder) {
    fatalError()
  }
}
