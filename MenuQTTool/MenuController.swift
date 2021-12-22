//
//  MenuController.swift
//  MenuQTTTool
//
//  Created by Emanuel Mairoll on 01.12.21.
//

import Foundation
import CocoaMQTT
import AppKit
import Defaults

class MenuController {

    private var currentSymbols: [String: String] = [:];
    private var symbolHandler: ([String]) -> Void = {_ in}
    private var mqtt: CocoaMQTT!

    init(){
        updateMQTTClient()
    }

    func updateMQTTClient(){
        guard let broker = Defaults[.broker] else {
            openConfigFileAndQuit()
        }

        if broker.host == exampleBroker.host && broker.port == exampleBroker.port {
            openConfigFileAndQuit()
        }

        let clientID = "CocoaMQTT" + String(ProcessInfo().processIdentifier)
        mqtt = CocoaMQTT(clientID: clientID, host: broker.host, port: broker.port)
        mqtt.username = ""
        mqtt.password = ""
        mqtt.willMessage = CocoaMQTTMessage(topic: "/will", string: "dieout")
        mqtt.keepAlive = 60

        mqtt!.didReceiveMessage = { _, message, _ in
            self.didReceiveMQTTMessage(message: message)
        }

        let _ = mqtt.connect()
        mqtt.didConnectAck = { _, ack in
            if ack == .accept {
                Defaults[.subscriptions]?.forEach { sub in
                    self.mqtt.subscribe(sub.mqttTopic)
                }
            }
        }


    }

    private func didReceiveMQTTMessage(message: CocoaMQTTMessage) {
        guard let subscriptions = Defaults[.subscriptions] else {
            return
        }

        guard let subscription = subscriptions.first(where: { $0.mqttTopic == message.topic }) else { return }

        guard let state = message.string else {
            print("Message on Topic " + message.topic + " was not a UTF8!")
            return
        }

        guard let symbol = subscription.stateToSymbol[state] else {
            print("No Symbol Mapping for State " + state + " on Topic " + subscription.mqttTopic )
            return
        }

        currentSymbols[subscription.mqttTopic] = symbol
        symbolHandler(Array(currentSymbols.values))
    }

    func setSymbolHandler(handler: @escaping ([String]) -> Void) {
        symbolHandler = handler
    }

}
