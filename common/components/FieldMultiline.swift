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
          field.backgroundColor = .secondarySystemBackground
          field.textContainerInset = .init(top: 0, left: -4, bottom: 0, right: -4)
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
  override class var layerClass: AnyClass { Background.self }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)

    layer.setNeedsLayout()
    layer.layoutIfNeeded()
  }

  internal class Background: CAShapeLayer {
    override init(layer: Any) {
      super.init(layer: layer)

      initialize()
    }

    override init() {
      super.init()

      initialize()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
      fatalError()
    }

    override func layoutSublayers() {
      super.layoutSublayers()

      let path = UIBezierPath(roundedRect: bounds, cornerRadius: 6)
      self.path = path.cgPath
      fillColor = UIColor.secondarySystemBackground.cgColor
    }

    private func initialize() {
      lineWidth = 1
      strokeColor = UIColor.black.withAlphaComponent(0.25).cgColor
    }
  }
}
