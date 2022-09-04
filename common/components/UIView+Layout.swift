//
//  UIView+Layout.swift
//  common
//
//  Created by Michael Ong on 9/4/22.
//

import Foundation
import UIKit

public extension UIView {
  func layout(
    around view: UIView,
    inset: UIEdgeInsets = .zero,
    excluding items: UIRectEdge...
  ) -> [NSLayoutConstraint] {
    return [
      items.contains(.left) ? nil : leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset.left),
      items.contains(.right) ? nil : trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset.right),
      items.contains(.top) ? nil : topAnchor.constraint(equalTo: view.topAnchor, constant: inset.top),
      items.contains(.bottom) ? nil : bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -inset.bottom),
    ].compactMap { $0 }
  }

  func layout(widthsOf view: UIView, inset: CGFloat = 0) -> [NSLayoutConstraint] {
    return [
      widthAnchor.constraint(equalTo: view.widthAnchor, constant: -inset),
    ]
  }

  func layout(heightsOf view: UIView, inset: CGFloat = 0) -> [NSLayoutConstraint] {
    return [
      heightAnchor.constraint(equalTo: view.heightAnchor, constant: -inset),
    ]
  }

  func layout(atTopOf view: UIView, gap: CGFloat = 0) -> [NSLayoutConstraint] {
    return [
      bottomAnchor.constraint(equalTo: view.topAnchor, constant: -gap),
    ]
  }

  func layout(atBottomOf view: UIView, gap: CGFloat = 0) -> [NSLayoutConstraint] {
    return [
      topAnchor.constraint(equalTo: view.bottomAnchor, constant: gap),
    ]
  }
}

public extension NSLayoutConstraint {
  static func activate(_ item1: [NSLayoutConstraint], _ item2: [NSLayoutConstraint]...) {
    var final = [item1]
    final.append(contentsOf: item2)

    NSLayoutConstraint.activate(final.flatMap { $0 })
  }
}

public func >= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
  lhs.constraint(greaterThanOrEqualToConstant: rhs)
}

public func <= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
  lhs.constraint(lessThanOrEqualToConstant: rhs)
}
