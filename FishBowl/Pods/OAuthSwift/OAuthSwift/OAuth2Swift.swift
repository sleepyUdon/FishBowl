//
//  OAuth2Swift.swift
//  OAuthSwift
//
//  Created by Dongri Jin on 6/22/14.
//  Copyright (c) 2014 Dongri Jin. All rights reserved.
//

import Foundation

open class OAuth2Swift: OAuthSwift {

    // If your oauth provider need to use basic authentification
    // set value to true (default: false)
    open var accessTokenBasicAuthentification = false

    // Set to true to deactivate state check. Be careful of CSRF
    open var allowMissingStateCheck: Bool = false

    var consumer_key: String
    var consumer_secret: String
    var authorize_url: String
    var access_token_url: String?
    var response_type: String
    var content_type: String?
    
    // MARK: init
    public convenience init(consumerKey: String, consumerSecret: String, authorizeUrl: String, accessTokenUrl: String, responseType: String){
        self.init(consumerKey: consumerKey, consumerSecret: consumerSecret, authorizeUrl: authorizeUrl, responseType: responseType)
        self.access_token_url = accessTokenUrl
    }

    public convenience init(consumerKey: String, consumerSecret: String, authorizeUrl: String, accessTokenUrl: String, responseType: String, contentType: String){
        self.init(consumerKey: consumerKey, consumerSecret: consumerSecret, authorizeUrl: authorizeUrl, responseType: responseType)
        self.access_token_url = accessTokenUrl
        self.content_type = contentType
    }

    public init(consumerKey: String, consumerSecret: String, authorizeUrl: String, responseType: String){
        self.consumer_key = consumerKey
        self.consumer_secret = consumerSecret
        self.authorize_url = authorizeUrl
        self.response_type = responseType
        super.init(consumerKey: consumerKey, consumerSecret: consumerSecret)
        self.client.credential.version = .oAuth2
    }
    
    public convenience init?(parameters: [String:String]){
        guard let consumerKey = parameters["consumerKey"], let consumerSecret = parameters["consumerSecret"],
            let responseType = parameters["responseType"], let authorizeUrl = parameters["authorizeUrl"] else {
                return nil
        }
        if let accessTokenUrl = parameters["accessTokenUrl"] {
            self.init(consumerKey:consumerKey, consumerSecret: consumerSecret,
                authorizeUrl: authorizeUrl, accessTokenUrl: accessTokenUrl, responseType: responseType)
        } else {
            self.init(consumerKey:consumerKey, consumerSecret: consumerSecret,
                authorizeUrl: authorizeUrl, responseType: responseType)
        }
    }

    open var parameters: [String: String] {
        return [
            "consumerKey": consumer_key,
            "consumerSecret": consumer_secret,
            "authorizeUrl": authorize_url,
            "accessTokenUrl": access_token_url ?? "",
            "responseType": response_type
        ]
    }

    // MARK: functions
    open func authorizeWithCallbackURL(_ callbackURL: URL, scope: String, state: String, params: [String: String] = [String: String](), success: TokenSuccessHandler, failure: @escaping ((_ error: NSError) -> Void)) {
        
         self.observeCallback { [unowned self] url in
            var responseParameters = [String: String]()
            if let query = url.query {
                responseParameters += query.parametersFromQueryString()
            }
            if let fragment = url.fragment , !fragment.isEmpty {
                responseParameters += fragment.parametersFromQueryString()
            }
            if let accessToken = responseParameters["access_token"] {
                self.client.credential.oauth_token = accessToken.safeStringByRemovingPercentEncoding
                success(credential: self.client.credential, response: nil, parameters: responseParameters)
            }
            else if let code = responseParameters["code"] {
                if !self.allowMissingStateCheck {
                    guard let responseState = responseParameters["state"] else {
                        let errorInfo = [NSLocalizedDescriptionKey: "Missing state"]
                        failure(NSError(domain: OAuthSwiftErrorDomain, code: OAuthSwiftErrorCode.missingStateError.rawValue, userInfo: errorInfo))
                        return
                    }
                    if responseState != state {
                        let errorInfo = [NSLocalizedDescriptionKey: "state not equals"]
                        failure(NSError(domain: OAuthSwiftErrorDomain, code: OAuthSwiftErrorCode.stateNotEqualError.rawValue, userInfo: errorInfo))
                        return
                    }
                }
                self.postOAuthAccessTokenWithRequestTokenByCode(code.safeStringByRemovingPercentEncoding,
                    callbackURL:callbackURL, success: success, failure: failure)
            }
            else if let error = responseParameters["error"], let error_description = responseParameters["error_description"] {
                let errorInfo = [NSLocalizedFailureReasonErrorKey: NSLocalizedString(error, comment: error_description)]
                failure(NSError(domain: OAuthSwiftErrorDomain, code: OAuthSwiftErrorCode.generalError.rawValue, userInfo: errorInfo))
            }
            else {
                let errorInfo = [NSLocalizedDescriptionKey: "No access_token, no code and no error provided by server"]
                failure(NSError(domain: OAuthSwiftErrorDomain, code: OAuthSwiftErrorCode.serverError.rawValue, userInfo: errorInfo))
            }
        }

        
        var queryString = "client_id=\(self.consumer_key)"
        queryString += "&redirect_uri=\(callbackURL.absoluteString)"
        queryString += "&response_type=\(self.response_type)"
        if !scope.isEmpty {
            queryString += "&scope=\(scope)"
        }
        if !state.isEmpty {
            queryString += "&state=\(state)"
        }
        for param in params {
            queryString += "&\(param.0)=\(param.1)"
        }
        
        var urlString = self.authorize_url
        urlString += (self.authorize_url.has("?") ? "&" : "?")
        
        if let encodedQuery = queryString.urlQueryEncoded, let queryURL = URL(string: urlString + encodedQuery) {
            self.authorize_url_handler.handle(queryURL)
        }
        else {
            let errorInfo = [NSLocalizedFailureReasonErrorKey: NSLocalizedString("Failed to create URL", comment: "\(urlString) or \(queryString) not convertible to URL, please check encoding")]
            failure(NSError(domain: OAuthSwiftErrorDomain, code: OAuthSwiftErrorCode.encodingError.rawValue, userInfo: errorInfo))
        }
    }
    
    func postOAuthAccessTokenWithRequestTokenByCode(_ code: String, callbackURL: URL, success: TokenSuccessHandler, failure: FailureHandler?) {
        var parameters = Dictionary<String, AnyObject>()
        parameters["client_id"] = self.consumer_key as AnyObject?
        parameters["client_secret"] = self.consumer_secret as AnyObject?
        parameters["code"] = code as AnyObject?
        parameters["grant_type"] = "authorization_code" as AnyObject?
        parameters["redirect_uri"] = callbackURL.absoluteString.safeStringByRemovingPercentEncoding as AnyObject?

        requestOAuthAccessTokenWithParameters(parameters, success: success, failure: failure)
    }
    
    func renewAccesstokenWithRefreshToken(_ refreshToken: String, success: TokenSuccessHandler, failure: FailureHandler?) {
        var parameters = Dictionary<String, AnyObject>()
        parameters["client_id"] = self.consumer_key as AnyObject?
        parameters["client_secret"] = self.consumer_secret as AnyObject?
        parameters["refresh_token"] = refreshToken as AnyObject?
        parameters["grant_type"] = "refresh_token" as AnyObject?
        
        requestOAuthAccessTokenWithParameters(parameters, success: success, failure: failure)
    }
    
    fileprivate func requestOAuthAccessTokenWithParameters(_ parameters: [String : AnyObject], success: TokenSuccessHandler, failure: FailureHandler?) {
        let successHandler: OAuthSwiftHTTPRequest.SuccessHandler = { [unowned self]
            data, response in
            let responseJSON: AnyObject? = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            
            let responseParameters: [String:String]
            
            if let jsonDico = responseJSON as? [String:AnyObject] {
                responseParameters = jsonDico.map { (key, value) in (key, String(value)) }
            } else {
                let responseString = NSString(data: data, encoding: String.Encoding.utf8) as String!
                responseParameters = responseString.parametersFromQueryString()
            }
            
            guard let accessToken = responseParameters["access_token"] else {
                if let failure = failure {
                    let errorInfo = [NSLocalizedFailureReasonErrorKey: NSLocalizedString("Could not get Access Token", comment: "Due to an error in the OAuth2 process, we couldn't get a valid token.")]
                    failure(error: NSError(domain: OAuthSwiftErrorDomain, code: OAuthSwiftErrorCode.serverError.rawValue, userInfo: errorInfo))
                }
                return
            }
            if let refreshToken:String = responseParameters["refresh_token"] {
                self.client.credential.oauth_refresh_token = refreshToken.safeStringByRemovingPercentEncoding
            }
            
            if let expiresIn:String = responseParameters["expires_in"], let offset = Double(expiresIn)  {
                self.client.credential.oauth_token_expires_at = Date(timeInterval: offset, since: Date())
            }
            
            self.client.credential.oauth_token = accessToken.safeStringByRemovingPercentEncoding
            success(credential: self.client.credential, response: response, parameters: responseParameters)
        }

        if self.content_type == "multipart/form-data" {
            // Request new access token by disabling check on current token expiration. This is safe because the implementation wants the user to retrieve a new token.
            self.client.postMultiPartRequest(self.access_token_url!, method: .POST, parameters: parameters, checkTokenExpiration: false, success: successHandler, failure: failure)
        } else {
            // special headers
            var headers: [String:String]? = nil
            if accessTokenBasicAuthentification {
                let authentification = "\(self.consumer_key):\(self.consumer_secret)".data(using: String.Encoding.utf8)
                if let base64Encoded = authentification?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
                {
                    headers = ["Authorization": "Basic \(base64Encoded)"]
                }
            }
            if let access_token_url = access_token_url {
                // Request new access token by disabling check on current token expiration. This is safe because the implementation wants the user to retrieve a new token.
                self.client.request(access_token_url, method: .POST, parameters: parameters, headers: headers, checkTokenExpiration: false, success: successHandler, failure: failure)
            }
            else {
                let errorInfo = [NSLocalizedFailureReasonErrorKey: NSLocalizedString("access token url not defined", comment: "access token url not defined with code type auth")]
                failure?(NSError(domain: OAuthSwiftErrorDomain, code: OAuthSwiftErrorCode.generalError.rawValue, userInfo: errorInfo))
            }
        }
    }

    /**
     Convenience method to start a request that must be authorized with the previosuly retrieved access token.
     Since OAuth 2 requires support for the access token refresh mechanism, this method will take care to automatically refresh the token if needed suche that the developer only has to be concerned about the outcome of the request.
     
     - parameter url:            The url for the request.
     - parameter method:         The HTTP method to use.
     - parameter parameters:     The request's parameters.
     - parameter headers:        The request's headers.
     - parameter onTokenRenewal: Optional callback triggered in case the access token renewal was required in order to properly authorize the request.
     - parameter success:        The success block. Takes the successfull response and data as parameter.
     - parameter failure:        The failure block. Takes the error as parameter.
     */
    open func startAuthorizedRequest(_ url: String, method: OAuthSwiftHTTPRequest.Method, parameters: Dictionary<String, AnyObject>, headers: [String:String]? = nil, onTokenRenewal: TokenRenewedHandler? = nil, success: OAuthSwiftHTTPRequest.SuccessHandler, failure: @escaping OAuthSwiftHTTPRequest.FailureHandler) {
        // build request
        self.client.request(url, method: method, parameters: parameters, headers: headers, success: success) { (error) in
            switch error.code {
            case OAuthSwiftErrorCode.tokenExpiredError.rawValue:
                self.renewAccesstokenWithRefreshToken(self.client.credential.oauth_refresh_token, success: { (credential, response, parameters) in
                    // We have successfully renewed the access token.
                    
                    // If provided, fire the onRenewal closure
                    if let renewalCallBack = onTokenRenewal {
                        renewalCallBack(credential: credential)
                    }
                    
                    // Reauthorize the request again, this time with a brand new access token ready to be used.
                    self.startAuthorizedRequest(url, method: method, parameters: parameters, headers: headers, onTokenRenewal: onTokenRenewal, success: success, failure: failure)
                    }, failure: failure)
            default:
                failure(error: error)
            }
        }
    }
    
    @available(*, deprecated: 0.5.0, message: "Use OAuthSwift.handleOpenURL()")
    open override class func handleOpenURL(_ url: URL) {
        super.handleOpenURL(url)
    }

}
