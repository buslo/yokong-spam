//
//  Group.swift
//  common
//
//  Created by Michael Ong on 9/4/22.
//

import Foundation
import UIKit

public class ComponentGroup: UIStackView {
  public static var horizontal: ComponentGroup {
    let group = ComponentGroup(arrangedSubviews: [])
    group.axis = .horizontal

    return group
  }

  public static var vertical: ComponentGroup {
    let group = ComponentGroup(arrangedSubviews: [])
    group.axis = .vertical

    return group
  }

  @discardableResult
  public func withMargins(_ margin: UIEdgeInsets, _ relativeToSafeArea: Bool = false) -> ComponentGroup {
    layoutMargins = margin
    isLayoutMarginsRelativeArrangement = true
    insetsLayoutMarginsFromSafeArea = relativeToSafeArea

    return self
  }

  @discardableResult
  public func withSpacing(_ amount: CGFloat) -> ComponentGroup {
    spacing = amount

    return self
  }

  @discardableResult
  public func withArrangedSubviews(@Builder _ subview: () -> WrapView) -> ComponentGroup {
    guard case let .list(views) = subview() else {
      fatalError()
    }

    for view in views {
      if case let .view(item) = view {
        addArrangedSubview(item)
      }
    }

    return self
  }
}

public extension ComponentGroup {
  @resultBuilder
  enum Builder {
    static func buildExpression<View: UIView>(_ expression: View) -> WrapView {
      .view(expression)
    }

    static func buildBlock(_ items: WrapView...) -> WrapView {
      .list(items)
    }
  }

  enum WrapView {
    case view(UIView)
    case list([WrapView])
  }
}
