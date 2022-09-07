//
//  Field.swift
//  common
//
//  Created by Michael Ong on 9/4/22.
//

import Foundation
import UIKit

public class ComponentField: UIView {
  public private(set) weak var labelView: UILabel!
  public private(set) weak var fieldView: UITextField!

  override public init(frame: CGRect) {
    super.init(frame: frame)

    addSubviewAndPrepare(ComponentGroup.vertical) { group in
      group.withMargins(.init(top: 8, left: 12, bottom: 4, right: 12)).withArrangedSubviews {
        prepareView(ref: &labelView, view: UILabel()) { label in
          label.font = .fontWithVariant(for: .label)
          label.alpha = 0.6
        }
        prepareView(ref: &fieldView, view: UITextField()) { field in
          field.font = .fontWithVariant(for: .body)
          field.borderStyle = .none

          NSLayoutConstraint.activate([
            field.heightAnchor.constraint(equalToConstant: 40),
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

public extension ComponentField {
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

      let inset = 1 / UIScreen.main.nativeScale
      let path = UIBezierPath(roundedRect: bounds.insetBy(dx: inset, dy: inset), cornerRadius: 6)
      self.path = path.cgPath

      strokeColor = UIColor.secondarySystemFill.cgColor
      fillColor = UIColor.systemBackground.cgColor
    }

    private func initialize() {
      lineWidth = 1
      masksToBounds = true
    }
  }
}
