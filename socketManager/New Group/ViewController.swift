//
//  ViewController.swift
//  ConnectToWifi
//
//  Created by Sasha on 23.08.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import UIKit
import NetworkExtension

class ViewController: UIViewController, WiFiConnectable {
    
   private var socketConnector: SocketConnectionProtocol!
    private var dataSocket: DataSocket!
   
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        socketConnector = SocketDataManager(with: self)
        dataSocket = DataSocket(ipAddress: "10.10.0.62", port: "50000")
        socketConnector.connectWith(socket: dataSocket)
        socketConnector.open()
        

        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func send(_ sender: UIButton) {
        socketConnector.send(message: "TEST")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
extension ViewController: PresenterProtocol{
    func updateStatusViewWith(status: String) {
        
    }
    
    
    func resetUIWithConnection(status: Bool){
        
           print(status)
     
    }
   
    func update(message: String){
        
     testLabel.text = message
        
    }
    
    
}

