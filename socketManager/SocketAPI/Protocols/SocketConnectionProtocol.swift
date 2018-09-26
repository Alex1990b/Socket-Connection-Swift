//
//  SocketConnectionProtocol.swift
//  ConnectToWifi
//
//  Created by Sasha on 23.08.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import Foundation

protocol SocketConnectionProtocol {
    func connectWith(socket: DataSocketProtocol)
    func open()
    func send(message: String)
    func close()
}
