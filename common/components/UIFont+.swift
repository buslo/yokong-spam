//
//  UIFont+.swift
//  common
//
//  Created by Michael Ong on 9/4/22.
//

import Foundation
import UIKit

public extension Common {
  enum FontVariant {
    case heading
    case heading2
    case heading3
    case body
    case body2
    case action
    case action2
    case label
  }
}

public extension UIFont {
  static func fontWithVariant(for variant: Common.FontVariant) -> UIFont {
    var attributes = [UIFontDescriptor.AttributeName: Any]()
    attributes[.family] = "Poppins"

    switch variant {
    case .heading:
      attributes[.traits] = [UIFontDescriptor.TraitKey.weight: UIFont.Weight.heavy.rawValue]
      attributes[.size] = CGFloat(28)
    case .heading2:
      attributes[.traits] = [UIFontDescriptor.TraitKey.weight: UIFont.Weight.heavy.rawValue]
      attributes[.size] = CGFloat(24)
    case .heading3:
      attributes[.traits] = [UIFontDescriptor.TraitKey.weight: UIFont.Weight.heavy.rawValue]
      attributes[.size] = CGFloat(20)
    case .body:
      attributes[.traits] = [UIFontDescriptor.TraitKey.weight: UIFont.Weight.regular.rawValue]
      attributes[.size] = CGFloat(16)
    case .body2:
      attributes[.traits] = [UIFontDescriptor.TraitKey.weight: UIFont.Weight.regular.rawValue]
      attributes[.size] = CGFloat(12)
    case .action:
      attributes[.traits] = [UIFontDescriptor.TraitKey.weight: UIFont.Weight.semibold.rawValue]
      attributes[.size] = CGFloat(16)
    case .action2:
      attributes[.traits] = [UIFontDescriptor.TraitKey.weight: UIFont.Weight.semibold.rawValue]
      attributes[.size] = CGFloat(12)
    case .label:
      attributes[.traits] = [UIFontDescriptor.TraitKey.weight: UIFont.Weight.medium.rawValue]
      attributes[.size] = CGFloat(10)
    }

    return UIFont(descriptor: .init(fontAttributes: attributes), size: attributes[.size] as! CGFloat)
  }
}
