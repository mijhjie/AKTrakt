//
//  Recommendations.swift
//  Pods
//
//  Created by Florian Morello on 27/05/16.
//
//

import Foundation
import Alamofire

public class TraktRequestRecommendations: TraktRequest, TraktRequest_Completion {
    var type: TraktMediaType

    public init(type: TraktMediaType, extended: TraktRequestExtendedOptions = .Min, pagination: TraktPagination = TraktPagination(page: 1, limit: 100)) {
        self.type = type
        var params: JSONHash = [:]
        params += extended.value()
        params += pagination.value()
        super.init(path: "/recommendations/\(type.rawValue)", params: params, tokenRequired: true)
    }

    public func request(trakt: Trakt, completion: ([TraktObject]?, NSError?) -> Void) throws -> Request? {
        return try trakt.request(self) { response in
            guard let entries = response.result.value as? [JSONHash] else {
                return completion(nil, response.result.error)
            }

            let list: [TraktObject] = entries.flatMap {
                guard let media = self.type == .Movies ? TraktMovie(data: $0 as? JSONHash) : TraktShow(data: $0 as? JSONHash) as? TraktObject else {
                    return nil
                }
                return media
            }
            completion(list, response.result.error)
        }
    }
}
