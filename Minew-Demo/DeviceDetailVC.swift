//
//  DeviceDetailVC.swift
//  Minew-Demo
//
//  Created by Harsh Vardhan Kushwaha on 08/02/24.
//

import UIKit
import MTBeaconPlus

class DeviceDetailVC: UIViewController {

    weak var device: MTPeripheral?
    
    @IBOutlet private weak var deviceStatus: UILabel!
    @IBOutlet private weak var deviceName: UILabel!
    @IBOutlet private weak var deviceMac: UILabel!
    @IBOutlet private weak var deviceVersion: UILabel!
    @IBOutlet private weak var deviceUuid: UILabel!
    @IBOutlet private weak var deviceSlotNumber: UILabel!
    @IBOutlet private weak var deviceSlotTxPower: UILabel!
    @IBOutlet private weak var deviceBattery: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let connector = device?.connector {
            self.deviceStatus.text = "Status: \(connector.status)"
            self.deviceName.text = "Name: " + (device?.framer.name ?? "")
            self.deviceMac.text = "Mac: " + (device?.framer.mac ?? "")
            self.deviceVersion.text = "Version: \(connector.version)"
            
            let frames = connector.allFrames
            
            frames?.forEach({ frame in
                if frame.frameType == .FrameiBeacon {
                    
                    if let beacon = frame as? MinewiBeacon {
                        self.deviceUuid.text = "UUID: " + beacon.uuid
                        self.deviceSlotNumber.text = "Slot: \(beacon.slotNumber)"
                        self.deviceSlotTxPower.text = "TxPower: \(beacon.txPower)"
                        self.deviceBattery.text = "Battery: \(beacon.battery)"
                    }
                }
            })
            connector.statusChangedHandler = { [weak self] (status, error) in
                self?.deviceStatus.text = "Status: \(status)"
                switch status {
                case.StatusDisconnected: self?.dismiss(animated: true)
                default: break
                }
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let device {
            BeaconPlusManager.sharedInstance.disconnectDevice(peripheral: device)
        }
    }
    
    @IBAction private func disconnectButtonDidTap(_ sender: UIButton) {
        if let device {
            BeaconPlusManager.sharedInstance.disconnectDevice(peripheral: device)
        }
        device = nil
    }
}
