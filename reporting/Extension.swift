//
//  UnwantedCommunicationReportingExtension.swift
//  reporting
//
//  Created by Michael Ong on 9/4/22.
//

import IdentityLookup
import IdentityLookupUI
import UIKit

class Extension: ILClassificationUIExtensionViewController {
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    extensionContext.isReadyForClassificationResponse = true
  }

  override func prepare(
    for _: ILClassificationRequest
  ) {}

  override func classificationResponse(
    for _: ILClassificationRequest
  ) -> ILClassificationResponse {
    return ILClassificationResponse(action: .none)
  }
}
