//
//  BLEDiscoverView.swift
//  MOswift
//
//  Created by Chong Guo on 4/1/16.
//  Copyright © 2016 Chong Guo. All rights reserved.
//

import Foundation
import UIKit
import BluetoothKit
import CoreBluetooth

class BLEDiscoverView: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate{
    
    @IBOutlet weak var ExitButton: UIButton!
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var connectionLabel: UILabel!
    @IBOutlet weak var connectionHeader: UILabel!
    
    let IRTemperatureServiceUUID = CBUUID(string: "6e400001-b5a3-f393-e0a9-e50e24dcca9e")
    let IRTemperatureDataUUID   = CBUUID(string: "6e400002-b5a3-f393-e0a9-e50e24dcca9e")
    let IRTemperatureConfigUUID = CBUUID(string:"6e400003-b5a3-f393-e0a9-e50e24dcca9e")
    let NOTIFY_MTU = 20
    
    var centralManager : CBCentralManager!
    var sensorTagPeripheral : CBPeripheral!
    var bleNames:NSMutableArray = NSMutableArray()
    var txCharacteristic: CBCharacteristic?
    var rxCharacteristic: CBCharacteristic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startUPcentral()
    }
    
    override func viewDidDisappear(animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startUPcentral(){
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    // Check status of BLE hardware
    func centralManagerDidUpdateState(central: CBCentralManager) {
        if central.state == CBCentralManagerState.PoweredOn {
            // Scan for peripherals if BLE is turned on
            central.scanForPeripheralsWithServices(nil, options: nil)
            print("Searching for BLE Devices")
        }
        else {
            // Can have different conditions for all states if needed - print generic message for now
            print("Bluetooth switched off or not initialized")
        }
    }
    
    // Check out the discovered peripherals to find Sensor Tag
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        sensorTagPeripheral = peripheral
        
        bleNames.addObject(peripheral)
        print("Available devices: \(bleNames)")
        
        let deviceName = "Adafruit Bluefruit LE"
        let nameOfDeviceFound = (advertisementData as NSDictionary).objectForKey(CBAdvertisementDataLocalNameKey) as? NSString
        
        if (nameOfDeviceFound == deviceName) {
            // Update Status Label
            print("Sensor Tag Reader Found")
            
            // Stop scanning
            self.centralManager.stopScan()
            // Set as the peripheral to use and establish connection
            self.sensorTagPeripheral = peripheral
            self.sensorTagPeripheral.delegate = self
            self.centralManager.connectPeripheral(peripheral, options: nil)
        }
        else {
            print("Sensor Tag Reader NOT Found")
        }
    }
    
    // Discover services of the peripheral
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        print("Discovering peripheral services")
        peripheral.discoverServices(nil)
    }
    
    // Check if the service discovered is a valid IR Temperature Service
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        print("Looking at peripheral services")
        if error != nil {
            print("\(error!.description)")
        } else {
            print("Found Service \n")
            for service in peripheral.services as [CBService]! {
                print("\(service.description)\n")
                peripheral.discoverCharacteristics(nil, forService: service)
            }
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        if error != nil {
            print("\(error!.description)")
            return
        } else {
            print("Enabling sensors")
            self.connectionLabel.text = "Connected"
            for characteristic in service.characteristics!{
                // And check if it's the right one
                switch characteristic.UUID {
                case IRTemperatureServiceUUID:
                    print("Service Characteristic\n")
                //displayInfoOutput("\n Hardware \n")
                case IRTemperatureConfigUUID:
                    peripheral.setNotifyValue(true, forCharacteristic: characteristic)
                    //displayInfoOutput("\n Read \n")
                    print("Read\n")
                    rxCharacteristic = characteristic
                case IRTemperatureDataUUID:
                    //displayInfoOutput("\n Write \n")
                    print("Write\n")
                    txCharacteristic = characteristic
                default:
                    print("Switch default")
                    //displayInfoOutput("\n")
                }
                
            }
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        
        print("Connected")
        
        if characteristic == rxCharacteristic {
            // Convert NSData to array of signed 16 bit values
            let dataBytes = characteristic.value
            print(characteristic.value)
            let dataLength = dataBytes!.length
            var dataArray = [Int16](count: dataLength, repeatedValue: 0)
            dataBytes!.getBytes(&dataArray, length: dataLength * sizeof(Int16))
            
            var endString = ""
            for a in dataArray{
                endString += String(a);
            }
            print(endString)
            readbleid = endString
            
            connectionHeader.text = endString
        }
    }

    
    
    @IBAction func addToObject(sender: AnyObject) {
        pushChildViewController()
        print("ButtonClicked")
    }

    func pushChildViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("AddEntryViewController") as UIViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}