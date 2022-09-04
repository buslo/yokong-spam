//
//  Common.swift
//  common
//
//  Created by Michael Ong on 9/4/22.
//

import CoreGraphics
import CoreText
import Foundation
import os.log

public enum Common {
  public static var bundleIdentifier = "tech.buslo.yokongspam.common"

  public static func initialize() {
    initFonts()
  }
}

public extension OSLog {
  static let commonFontLoading = OSLog(subsystem: Common.bundleIdentifier, category: "common:font")
}

func initFonts() {
  let fontVariants = [
    "Black",
    "Bold",
    "ExtraBold",
    "ExtraLight",
    "Light",
    "Medium",
    "Regular",
    "SemiBold",
    "Thin",
  ]

  let withItalics = fontVariants.flatMap { variant in [variant, "\(variant)Italic"] }
  let bundle = Bundle(identifier: Common.bundleIdentifier)

  let dispatchGroup = DispatchGroup()
  let dispatchQueue = DispatchQueue(label: "\(Common.bundleIdentifier).thread.fontloader", attributes: [.concurrent])

  for fontName in withItalics {
    dispatchQueue.async(group: dispatchGroup) {
      guard let path = bundle?.url(forResource: "Poppins-\(fontName)", withExtension: "ttf"),
            let data = try? Data(contentsOf: path),
            let font = CGDataProvider(data: data as NSData), let fontReference = CGFont(font)
      else {
        return
      }

      guard CTFontManagerRegisterGraphicsFont(fontReference, nil) else {
        return
      }
    }
  }

  os_log("Loading", log: .commonFontLoading, type: .info)
  dispatchGroup.wait()

  os_log("Loaded", log: .commonFontLoading, type: .info)
}
