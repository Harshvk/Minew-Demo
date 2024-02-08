//
//  BeaconPlusManager.swift
//  Minew-Demo
//
//  Created by Harsh Vardhan Kushwaha on 08/02/24.
//

import Foundation
import MTBeaconPlus

class BeaconPlusManager {
    
    private init(){}
    
    static let sharedInstance = BeaconPlusManager()
    
    private let manager = MTCentralManager.sharedInstance()
    
    func scanDevices(completion: (([MTPeripheral])->())?) {
        manager?.startScan({ peripherals in
            completion?(peripherals ?? [])
            
            peripherals?.forEach({ peripheral in
                print("NAME====>",peripheral.framer.name)
                print("MAC====>",peripheral.framer.mac)
                print("CONNECTABLE====>",peripheral.framer.connectable)
                print("RSSI====>",peripheral.framer.rssi)
            })
        })
    }
    
    func stopScan() {
        manager?.stopScan()
    }
    
    func connectDevice(peripheral:MTPeripheral,password: String){
        manager?.connect(toPeriperal: peripheral, passwordRequire: { passworkBlock in
            passworkBlock?(password)
        })
    }
    
    func disconnectDevice(peripheral:MTPeripheral) {
        manager?.disconnect(fromPeriperal: peripheral)
    }
    
}
