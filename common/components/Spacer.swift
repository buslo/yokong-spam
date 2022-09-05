//
//  Spacer.swift
//  common
//
//  Created by Michael Ong on 9/5/22.
//

import Foundation
import UIKit

public class Spacer: UIView {
  weak var heightConstraint: NSLayoutConstraint!

  public var height: CGFloat = 0 {
    didSet {
      heightConstraint.constant = height
      setNeedsUpdateConstraints()
    }
  }

  override public init(frame: CGRect) {
    super.init(frame: frame)

    translatesAutoresizingMaskIntoConstraints = false

    let constraint = heightAnchor.constraint(equalToConstant: height)
    constraint.isActive = true

    heightConstraint = constraint
  }

  @available(*, unavailable)
  public required init?(coder _: NSCoder) {
    fatalError()
  }
}
