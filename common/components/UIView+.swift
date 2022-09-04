//
//  UIView+.swift
//  common
//
//  Created by Michael Ong on 9/4/22.
//

import Foundation
import UIKit

public extension UIView {
  @discardableResult
  func addSubviewAndPrepare<View: UIView>(
    _ view: View,
    _ autoLayout: Bool = true,
    preparation: (View) -> Void
  ) -> View {
    if autoLayout {
      view.translatesAutoresizingMaskIntoConstraints = false
    }

    addSubview(view)
    preparation(view)

    return view
  }
}

@discardableResult
public func prepareView<View: UIView>(view: View, _ autoLayout: Bool = true, _ prepare: (View) -> Void) -> View {
  if autoLayout {
    view.translatesAutoresizingMaskIntoConstraints = false
  }

  prepare(view)
  return view
}

@discardableResult
public func prepareView<View: UIView>(
  ref: inout View?,
  view: View,
  _ autoLayout: Bool = true,
  _ prepare: (View) -> Void
) -> View {
  if autoLayout {
    view.translatesAutoresizingMaskIntoConstraints = false
  }

  ref = view

  prepare(view)
  return view
}
