//
//  Extension.swift
//  filter
//
//  Created by Michael Ong on 9/4/22.
//

import IdentityLookup

final class Extension: ILMessageFilterExtension {}

extension Extension: ILMessageFilterQueryHandling, ILMessageFilterCapabilitiesQueryHandling {
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
    _ queryRequest: ILMessageFilterQueryRequest,
    context: ILMessageFilterExtensionContext,
    completion: @escaping (ILMessageFilterQueryResponse) -> Void
  ) {
    let (offlineAction, offlineSubAction) = self.offlineAction(for: queryRequest)

    switch offlineAction {
    case .allow, .junk, .promotion, .transaction:
      let response = ILMessageFilterQueryResponse()
      response.action = offlineAction
      response.subAction = offlineSubAction

      completion(response)
    case .none:
      context.deferQueryRequestToNetwork { networkResponse, error in
        let response = ILMessageFilterQueryResponse()
        response.action = .none
        response.subAction = .none

        if let networkResponse = networkResponse {
          (response.action, response.subAction) = self.networkAction(for: networkResponse)
        } else {
          NSLog("Error deferring query request to network: \(String(describing: error))")
        }

        completion(response)
      }

    @unknown default:
      break
    }
  }

  private func offlineAction(
    for _: ILMessageFilterQueryRequest
  ) -> (ILMessageFilterAction, ILMessageFilterSubAction) {
    // TODO: Replace with logic to perform offline check whether to filter first (if possible).
    return (.none, .none)
  }

  private func networkAction(
    for _: ILNetworkResponse
  ) -> (ILMessageFilterAction, ILMessageFilterSubAction) {
    // TODO: Replace with logic to parse the HTTP response and data payload of `networkResponse` to return an action.
    return (.none, .none)
  }
}
