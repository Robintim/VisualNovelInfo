//
//  URLConfiguration.swift
//  VisualNovelInfo
//
//  Created by Daniel Alberto Vazquez Rodriguez on 14/06/25.
//

import Foundation

struct URLConfiguration {
    var strMethod: String
    var strHost: String
    var path: PathsProtocol
    private var strCurrentLocale: String {
        return Locale.current.language.languageCode?.identifier ?? ""
    }
    
    public init(strMethod: String = "https", strHost: String = "api.vndb.org", path: PathsProtocol) {
        self.strMethod = strMethod
        self.strHost = strHost
        self.path = path
    }
    
    public func configureURL(withQueryItems arrQueryItems: [URLQueryItem]? = nil) -> URL? {
        guard !strHost.isEmpty else { return nil }
        var components = URLComponents()
        components.scheme = strMethod
        components.host = strHost
        components.path = path.strPathToUse
        components.queryItems = arrQueryItems
        return components.url
    }
}

protocol PathsProtocol {
    var strPathToUse: String { get }
}

extension String: PathsProtocol {
    var strPathToUse: String {
        return self
    }
}
