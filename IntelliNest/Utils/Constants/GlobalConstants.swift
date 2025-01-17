//
//  Constants.swift
//  IntelliNest
//
//  Created by Tobias on 2022-02-01.
//

import Foundation

struct GlobalConstants {
    static var baseExternalUrlString: String {
        if let externalUrl = Bundle.main.object(forInfoDictionaryKey: "EXTERNAL_URL") as? String {
            return "https://\(externalUrl)"
        }
        return ""
    }

    static var secretHassToken: String {
        if let hassToken = Bundle.main.object(forInfoDictionaryKey: "SECRET_HASS_TOKEN") as? String {
            return hassToken
        }
        return ""
    }

    static var secretShipBookAppID: String {
        if let shipBookAppID = Bundle.main.object(forInfoDictionaryKey: "SECRET_SHIP_BOOK_APP_ID") as? String {
            return shipBookAppID
        }
        return ""
    }

    static var secretShipBookAppKey: String {
        if let shipBookAppKey = Bundle.main.object(forInfoDictionaryKey: "SECRET_SHIP_BOOK_APP_KEY") as? String {
            return shipBookAppKey
        }
        return ""
    }

    static var secretYaleAPIURL: String {
        if let yaleAPIURL = Bundle.main.object(forInfoDictionaryKey: "SECRET_YALE_API_URL") as? String {
            return "https://\(yaleAPIURL)"
        }
        return ""
    }

    static var secretYaleAPIKey: String {
        if let yaleAPIKey = Bundle.main.object(forInfoDictionaryKey: "SECRET_YALE_API_KEY") as? String {
            return yaleAPIKey
        }
        return ""
    }

    static var secretRTSPURLBackCamera: String {
        if let rtspURL = Bundle.main.object(forInfoDictionaryKey: "SECRET_RTSP_STREAM_CAMERA_BACK") as? String {
            return "rtsp://\(rtspURL)"
        }
        return ""
    }

    static var secretRTSPURLFrontCamera: String {
        if let rtspURL = Bundle.main.object(forInfoDictionaryKey: "SECRET_RTSP_STREAM_CAMERA_FRONT") as? String {
            return "rtsp://\(rtspURL)"
        }
        return ""
    }

    static var secretRTSPURLCarportkCamera: String {
        if let rtspURL = Bundle.main.object(forInfoDictionaryKey: "SECRET_RTSP_STREAM_CAMERA_CARPORT") as? String {
            return "rtsp://\(rtspURL)"
        }
        return ""
    }

    static var secretRTSPURLVinceCamera: String {
        if let rtspURL = Bundle.main.object(forInfoDictionaryKey: "SECRET_RTSP_STREAM_CAMERA_VINCE") as? String {
            return "rtsp://\(rtspURL)"
        }
        return ""
    }

    static let baseInternalUrlString = "http://192.168.1.205:8123/"
    static let githubFakeUrlString = "https://192.218.223.123/"

    static func isGithubActionsRunning() -> Bool {
        return baseExternalUrlString == githubFakeUrlString
    }
}
