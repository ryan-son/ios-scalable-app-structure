//
//  AuthTokenRequest.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/01.
//

/**
Request for getting an authentication token

{
"grant_type": "client_credentials",
"client_id": "CLIENT-ID",
"client_secret": "CLIENT-SECRET"
}
*/
enum AuthTokenRequest: RequestProtocol {
  case auth

  var path: String {
    return "/v2/oauth2/token"
  }

  var params: [String : Any] {
    return [
      "grant_type": ApiConstants.grantType,
      "client_id": ApiConstants.clientId,
      "client_secret": ApiConstants.clientSecret
    ]
  }

  var addAuthorizationToken: Bool {
    return false
  }

  var requestType: RequestType {
    return .post
  }
}
