//
//  Subscription.swift
//  MenuQTTTool
//
//  Created by Emanuel Mairoll on 24.11.21.
//

import Cocoa
import Defaults

struct Subscription {
    let mqttTopic: String
    let stateToSymbol: [String: String];
    let stateToCommand: [String: String];
}

struct Broker {
    let host: String
    let port: UInt16
}

let exampleSubscription = Subscription(mqttTopic: "some/mqtt/topic", stateToSymbol: ["on": "✅", "off": "❎"], stateToCommand: [:])
let exampleBroker = Broker(host: "example.com", port: 0)

extension Defaults.Keys {
    static let subscriptions = Defaults.Key<[Subscription]?>("subscriptions")
    static let broker = Defaults.Key<Broker?>("broker")
}

func openConfigFileAndQuit() -> Never {
    // Please, do not ask...
    // cfprefsd behaves pretty strangely...
    if Defaults[.subscriptions] == nil {
        Defaults[.subscriptions] = [exampleSubscription]
    }
    if Defaults[.broker] == nil {
        Defaults[.broker] = exampleBroker
    }

    UserDefaults.standard.synchronize()

    let path: [AnyObject] = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true) as [AnyObject]
    let prefFile: String = path[0] as! String + "/Preferences/" + Bundle.main.bundleIdentifier! + ".plist"
    NSWorkspace.shared.open(URL(fileURLWithPath: prefFile))

    exit(0)
}

