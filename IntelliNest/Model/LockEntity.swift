//
//  LockEntity.swift
//  IntelliNest
//
//  Created by Tobias on 2022-04-19.
//

import Foundation
import ShipBookSDK

struct LockEntity: Lockable, EntityProtocol {
    var entityId: EntityId
    var id: LockID = .storageDoor
    var state: String { didSet {
        print("asd123123sad")
        lockState = LockState(rawValue: state) ?? .unknown
        if lockState == expectedState || expectedStateIsOld {
            expectedState = .unknown
        }
    }}
    var nextUpdate = NSDate().addingTimeInterval(-1)
    var expectedStateSetDate: Date?

    var lockState: LockState = .unknown
    var expectedState: LockState = .unknown {
        didSet {
            self.expectedStateSetDate = Date()
        }
    }

    enum CodingKeys: String, CodingKey {
        case entityId = "entity_id"
        case state
    }

    init(entityId: EntityId, state: String = "Loading") {
        self.entityId = entityId
        self.state = state
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let entityId = try EntityId(rawValue: container.decode(String.self, forKey: .entityId))
        self.entityId = entityId ?? EntityId.unknown
        state = try container.decode(String.self, forKey: .state)
        lockState = LockState(rawValue: state) ?? .unknown
    }

    static func == (lhs: LockEntity, rhs: LockEntity) -> Bool {
        return (lhs.isActive == rhs.isActive &&
            lhs.entityId == rhs.entityId &&
            lhs.state == rhs.state)
    }

    func shouldReload() -> Bool {
        return isActive || isLoading
    }

    mutating func setNextUpdateTime() {
        nextUpdate = NSDate().addingTimeInterval(0.29)
    }
}
