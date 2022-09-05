//
//  FieldMultiline.swift
//  common
//
//  Created by Michael Ong on 9/4/22.
//

import Foundation
import UIKit

public class ComponentFieldMultiline: UIView {
  public private(set) weak var labelView: UILabel!
  public private(set) weak var fieldView: UITextView!

  override public init(frame: CGRect) {
    super.init(frame: frame)

    addSubviewAndPrepare(ComponentGroup.vertical) { group in
      group.withMargins(.init(top: 8, left: 12, bottom: 4, right: 12)).withArrangedSubviews {
        prepareView(ref: &labelView, view: UILabel()) { label in
          label.font = .fontWithVariant(for: .label)
          label.alpha = 0.6
        }
        prepareView(ref: &fieldView, view: UITextView()) { field in
          field.font = .fontWithVariant(for: .body)
          field.isScrollEnabled = false
          field.backgroundColor = .systemBackground
          field.textContainerInset = .init(top: 8, left: -4, bottom: 8, right: -4)
          field.contentInset = .zero

          NSLayoutConstraint.activate([
            field.heightAnchor >= 120,
          ])
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

public extension ComponentFieldMultiline {
  override class var layerClass: AnyClass { ComponentField.Background.self }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)

    layer.setNeedsLayout()
    layer.layoutIfNeeded()
  }
}
