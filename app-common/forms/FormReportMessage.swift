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

  let optionItems: [ComponentFieldOption.OptionItem] = [
    .init(
      id: "junk",
      icon: UIImage(systemName: "xmark.bin"),
      title: "Junk",
      description: "This message should not even be in my inbox!"
    ),
    .init(
      id: "finance",
      icon: UIImage(systemName: "creditcard"),
      title: "Finance",
      description: "This message is usually sent by my bank / wallet app."
    ),
    .init(
      id: "orders",
      icon: UIImage(systemName: "shippingbox"),
      title: "Delivery",
      description: "This message is usually sent by couriers to inform me about my order."
    ),
    .init(
      id: "promotion",
      icon: UIImage(systemName: "gift"),
      title: "Promotions and Coupons",
      description: "This message is for promotions or coupons."
    ),
  ]

  public weak var fieldSMSNumber: ComponentField!
  public weak var fieldSMSContent: ComponentFieldMultiline!

  override public init(frame: CGRect) {
    super.init(frame: frame)

    contentView = addSubviewAndPrepare(ComponentGroup.vertical) { group in
      group.withSpacing(12).withArrangedSubviews {
        prepareView(view: UILabel()) { label in
          label.font = .fontWithVariant(for: .heading3)
          label.text = "Report SMS"
        }
        prepareView(ref: &fieldSMSNumber, view: ComponentField()) { field in
          field.labelView.text = "Number"
        }
        prepareView(ref: &fieldSMSContent, view: ComponentFieldMultiline()) { field in
          field.labelView.text = "Content"
        }
        prepareView(view: ComponentFieldOption()) { field in
          field.labelView.text = "What Kind"
          field.optionItems = optionItems
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
