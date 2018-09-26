//
//  ViewController.swift
//  ConnectToWifi
//
//  Created by Sasha on 23.08.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import UIKit
import NetworkExtension

final class ViewController: UIViewController {
    
   @IBOutlet private weak var testLabel: UILabel!  
    
   private var socketConnector: SocketConnectionProtocol!
   private var dataSocket: DataSocket!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        socketConnector = SocketDataManager(with: self)
        dataSocket = DataSocket(ipAddress: "10.10.0.62", port: "50000")
        socketConnector.connectWith(socket: dataSocket)
        socketConnector.open()
    }    
}

extension ViewController: PresenterProtocol{
    func updateStatusViewWith(status: String) {
    }
    
    func resetUIWithConnection(status: Bool) {
    }
   
    func update(message: String){ }
}

private extension ViewController {
    
      @IBAction func send(_ sender: UIButton) {
        socketConnector.send(message: "TEST")
    }
}

