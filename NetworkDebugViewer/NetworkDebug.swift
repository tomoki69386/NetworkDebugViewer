//
//  NetworkDebug.swift
//  NetworkDebugViewer
//
//  Created by 築山朋紀 on 2019/12/27.
//  Copyright © 2019 tomoki_sun. All rights reserved.
//

import Foundation

public struct NetworkDebug {
    private let response: HTTPURLResponse?
    public let request: URLRequest
    private let data: Data
    
    public init(_ response: HTTPURLResponse?, request: URLRequest, data: Data?) {
        self.response = response
        self.request = request
        self.data = data ?? Data()
    }
    
    public var url: URL? {
        return request.url
    }
    public var httpMethod: String {
        return request.httpMethod ?? ""
    }
    public var statusCode: String {
        guard let statusCode = response?.statusCode else {
            return "-"
        }
        return "\(statusCode)"
    }
    public var requestBody: String {
        guard let body = request.httpBody, let stringOutput = String(data: body, encoding: .utf8) else {
            return ""
        }
        return stringOutput
    }
    public var responseBody: String {
        guard let stringOutput = String(data: data, encoding: .utf8) else {
            return ""
        }
        return stringOutput
    }
    func allHeaderFields(_ string: String) -> String {
        if let data = response?.allHeaderFields[string] {
            return "\(data)"
        }
        return "-"
    }
    func allHTTPHeaderFields(_ string: String) -> String {
        if let data = request.allHTTPHeaderFields?[string] {
            return data
        }
        return "-"
    }
}
