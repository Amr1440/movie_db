//
//  Api.swift
//  MovieDp
//
//  Created by Amr Sayed on 1/5/21.
//

import Alamofire
import RxSwift
import PromiseKit
import UIKit

class Api: NSObject {
    var params: RequestParamters?
    var requestType: Requestable?
    var result = ""
    var requestsId = ""

    func getApiName() -> String {
        return ""
    }

    func beginBackgroundUpdateTask() -> UIBackgroundTaskIdentifier {
        return UIApplication.shared.beginBackgroundTask(expirationHandler: ({}))
    }

    func endBackgroundUpdateTask(taskID: UIBackgroundTaskIdentifier) {
        UIApplication.shared.endBackgroundTask(taskID)
    }

    func cancel() {
        ServiceManager.shared.cancelRequestWithID(requestID: requestsId)
    }
}

extension Api {
    func fireRequestWithSingleResponse<T: Codable>(requestable: Requestable) -> Promise<T> {
        let taskId = beginBackgroundUpdateTask()

        return Promise<T> { seal in
            let completionHandler: (DataResponse<T>) -> Void = { response in
                self.endBackgroundUpdateTask(taskID: taskId)
                guard response.error == nil else {
                    if (response.error as? URLError) != nil {
                        // no internet connection
                        let errorN = CustomError(code: "00-000", message: "Sorry, Please check your internet connection")
                        seal.reject(errorN)
                        return
                    }
                    seal.reject(CustomError.getError(error: response.error!))
                    return
                }
                guard response.value != nil else {
                    _ = NSError(domain: "JSONResponseError", code: 3841, userInfo: nil)
                    seal.reject(CustomError.getError(error: response.error!))
                    return
                }
                seal.fulfill(response.result.value!)
            }

            requestable.request(requestID: requestsId, with: completionHandler)
        }
    }

    func fireRequestWithCustomResponse(requestable: Requestable, complition: @escaping (([String: Any]?, Error?) -> Void)) {
        let completionHandler: (DataResponse<Any>) -> Void = { response in
            guard response.error == nil else {
                if (response.error as? URLError) != nil {
                    complition(nil, nil)
                    return
                }

                complition(nil, nil)
                return
            }
            guard response.value != nil else {
                _ = NSError(domain: "JSONResponseError", code: 3841, userInfo: nil)
                complition(nil, response.error!)
                return
            }

            let result: [String: Any] = response.result.value as? [String: Any] ?? [:]

         

            complition(result, nil)
        }
        requestable.request(requestID: requestsId, with: completionHandler)
    }
}
