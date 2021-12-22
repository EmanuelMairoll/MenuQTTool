//
//  Serialisation.swift
//  MenuQTTool
//
//  Created by Emanuel Mairoll on 22.12.21.
//

import Foundation
import Defaults

extension Subscription: Defaults.Serializable {
    static let bridge = SubscriptionBridge()
}

struct SubscriptionBridge: Defaults.Bridge {
    typealias Value = Subscription
    typealias Serializable = [String: Any]

    public func serialize(_ value: Value?) -> Serializable? {
        guard let value = value else {
            return nil
        }

        return [
            "mqttTopic": value.mqttTopic,
            "stateToSymbol": value.stateToSymbol
        ]
    }

    public func deserialize(_ object: Serializable?) -> Value? {
        guard
            let object = object,
            let mqttTopic = object["mqttTopic"] as? String,
            let stateToSymbol = object["stateToSymbol"] as? [String: String]
        else {
            return nil
        }

        return Subscription(mqttTopic: mqttTopic, stateToSymbol: stateToSymbol)
    }
}

extension Broker: Defaults.Serializable {
    static let bridge = BrokerBridge()
}

struct BrokerBridge: Defaults.Bridge {
    typealias Value = Broker
    typealias Serializable = [String: Any]

    public func serialize(_ value: Value?) -> Serializable? {
        guard let value = value else {
            return nil
        }

        return [
            "host": value.host,
            "port": value.port
        ]
    }

    public func deserialize(_ object: Serializable?) -> Value? {
        guard
            let object = object,
            let host = object["host"] as? String,
            let port = object["port"] as? UInt16
        else {
            return nil
        }

        return Broker(host: host, port: port)
    }

}

