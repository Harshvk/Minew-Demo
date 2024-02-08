//
//  ViewController.swift
//  Minew-Demo
//
//  Created by Harsh Vardhan Kushwaha on 04/02/24.
//

import UIKit
import MTBeaconPlus

class ViewController: UIViewController {

    private var devices: [MTPeripheral] = []
    
    @IBOutlet weak var deviceTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        deviceTableView.dataSource = self
        deviceTableView.delegate = self
        deviceTableView.register(DeviceTableCell.self, forCellReuseIdentifier: "DeviceTableCell")
        scanDevices()
    }
    
    func scanDevices() {
        BeaconPlusManager.sharedInstance.scanDevices {[weak self] devices in
            self?.devices = devices
            self?.deviceTableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceTableCell", for: indexPath) as? DeviceTableCell else{
            fatalError("Failed to deque cell")
        }
        let device = devices[indexPath.row]
        cell.setupCell(name: device.framer.name ?? "", mac: device.framer.mac ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let device = devices[indexPath.row]
        self.openAlertWithTextfield(title: "Enter Password") {[weak self] password in
            guard let self else {return}
            if !password.isEmpty {
                let connector = device.connector
                connector?.statusChangedHandler = { (status,error) in
                    print(status,error?.localizedDescription ?? "")
                    switch status {
                    case .StatusConnected: 
                        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DeviceDetailVC") as? DeviceDetailVC {
                            vc.device = device
                            self.present(vc, animated: true)
                        }
                    default: break
                    }
                }
                BeaconPlusManager.sharedInstance.connectDevice(peripheral: device, password: password)
            }
        }
    }
}
