//
//  UnwantedCommunicationReportingExtension.swift
//  reporting
//
//  Created by Michael Ong on 9/4/22.
//

import IdentityLookup
import IdentityLookupUI
import UIKit
import YokongAppCommon

class Extension: ILClassificationUIExtensionViewController {
  lazy var controllerView = ExtensionView()

  override func loadView() {
    AppCommon.initialize()

    view = controllerView
  }

  override func prepare(
    for request: ILClassificationRequest
  ) {
    switch request {
    case let msms as ILMessageClassificationRequest:
      controllerView.prepareForMessage(msms)
    case let call as ILCallClassificationRequest:
      controllerView.prepareForCall(call)
    default:
      break
    }
  }

  override func classificationResponse(
    for _: ILClassificationRequest
  ) -> ILClassificationResponse {
    return ILClassificationResponse(action: .none)
  }
}
