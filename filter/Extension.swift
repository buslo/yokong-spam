//
//  Extension.swift
//  filter
//
//  Created by Michael Ong on 9/4/22.
//

import IdentityLookup

final class Extension: ILMessageFilterExtension {}

extension Extension: ILMessageFilterQueryHandling, ILMessageFilterCapabilitiesQueryHandling {
  @available(iOSApplicationExtension 16.0, *)
  func handle(
    _: ILMessageFilterCapabilitiesQueryRequest,
    context _: ILMessageFilterExtensionContext,
    completion: @escaping (ILMessageFilterCapabilitiesQueryResponse) -> Void
  ) {
    let response = ILMessageFilterCapabilitiesQueryResponse()

    response.promotionalSubActions = [.promotionalOthers]
    response.transactionalSubActions = [
      .transactionalOrders,
      .transactionalFinance,
      .transactionalHealth,
      .transactionalCarrier,
    ]

    completion(response)
  }

  func handle(
    _: ILMessageFilterQueryRequest,
    context _: ILMessageFilterExtensionContext,
    completion: @escaping (ILMessageFilterQueryResponse) -> Void
  ) {
    let response = ILMessageFilterQueryResponse()
    response.action = .allow

    if #available(iOSApplicationExtension 16.0, *) {
      response.subAction = .none
    }

    completion(response)
  }
}
