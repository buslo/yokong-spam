//
//  UnwantedCommunicationReportingExtension.swift
//  reporting
//
//  Created by Michael Ong on 9/4/22.
//

import IdentityLookup
import IdentityLookupUI
import UIKit
import YokongCommon

class Extension: ILClassificationUIExtensionViewController {
  lazy var controllerView = ExtensionView()

  override func loadView() {
    Common.initialize()

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

    extensionContext.isReadyForClassificationResponse = true
  }

  override func classificationResponse(
    for _: ILClassificationRequest
  ) -> ILClassificationResponse {
    return ILClassificationResponse(action: .none)
  }
}
