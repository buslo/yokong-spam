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
    priorities: [UIRectEdge: UILayoutPriority] = [:],
    excluding items: UIRectEdge...
  ) -> [NSLayoutConstraint] {
    return [
      items.contains(.left)
        ? nil
        : leadingAnchor
        .constraint(equalTo: view.leadingAnchor, constant: inset.left)
        .withPriority(priorities[.left]),
      items.contains(.right)
        ? nil
        : trailingAnchor
        .constraint(equalTo: view.trailingAnchor, constant: -inset.right)
        .withPriority(priorities[.right]),
      items.contains(.top)
        ? nil
        : topAnchor
        .constraint(equalTo: view.topAnchor, constant: inset.top)
        .withPriority(priorities[.top]),
      items.contains(.bottom)
        ? nil
        : bottomAnchor
        .constraint(equalTo: view.bottomAnchor, constant: -inset.bottom)
        .withPriority(priorities[.bottom]),
    ].compactMap { $0 }
  }

  func layout(widthsOf view: UIView, inset: CGFloat = 0) -> [NSLayoutConstraint] {
    switch view {
    case let scrollView as UIScrollView:
      return [
        widthAnchor.constraint(
          equalTo: scrollView.frameLayoutGuide.widthAnchor,
          constant: -(scrollView.contentInset.left + scrollView.contentInset.right + inset)
        ),
      ]
    default:
      return [
        widthAnchor.constraint(equalTo: view.widthAnchor, constant: -inset),
      ]
    }
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

  func withPriority(_ priority: UILayoutPriority?) -> NSLayoutConstraint {
    if let priority {
      self.priority = priority
    }

    return self
  }
}

extension UIRectEdge: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(rawValue)
  }
}

public extension UIEdgeInsets {
  init(vertical: CGFloat, horizontal: CGFloat) {
    self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
  }

  init(top: CGFloat, horizontal: CGFloat, bottom: CGFloat) {
    self.init(top: top, left: horizontal, bottom: bottom, right: horizontal)
  }
}

public func == (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
  lhs.constraint(equalTo: rhs)
}

public func == (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
  lhs.constraint(equalToConstant: rhs)
}

public func >= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
  lhs.constraint(greaterThanOrEqualToConstant: rhs)
}

public func <= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
  lhs.constraint(lessThanOrEqualToConstant: rhs)
}
