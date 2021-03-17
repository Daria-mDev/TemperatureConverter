//
//  ViewController.swift
//  TemperatureConverter
//
//  Created by user on 16.03.2021.
//

import UIKit

enum Temperature: CaseIterable {
    case celsius
    case fahrenheit
    case kelvin
    
    func description() -> String {
        switch self {
        case .celsius:
            return "Celsius"
        case .fahrenheit:
            return "Fahrenheit"
        case .kelvin:
            return "Kelvin"
        }
    }
    
    
    func convertTo(temperatureScale scale: Temperature, value inputValue: Double) -> Double {
        var result = inputValue
        
        switch self {
        case .celsius:
            if scale == .fahrenheit {
                result = inputValue * 1.8 + 32
            }
            else if scale == .kelvin {
                result = inputValue + 273.15
            }
        case .fahrenheit:
            if scale == .celsius {
                result = (inputValue - 32) / 1.8
            }
            else if scale == .kelvin {
                result = (inputValue + 459.67) / 1.8
            }
        case .kelvin:
            if scale == .celsius {
                result = inputValue - 273.15
            }
            else if scale == .fahrenheit {
                result = inputValue * 1.8 - 459.67
            }
        }
        return result
    }
}


class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var conversionPicker: UIPickerView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
   
    let temperatureScales = Temperature.allCases
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conversionPicker.delegate = self
        conversionPicker.dataSource = self
    }


    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        temperatureScales.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return temperatureScales[row].description()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component:Int) {
        setConvertionValue()
    }
    
    @IBAction func temperatureInputChanged(_ sender: Any) {
        setConvertionValue()
    }
    
    
    func setConvertionValue() {
        let fromTemperatureIdx = conversionPicker.selectedRow(inComponent: 0)
        let toTemperatureIdx = conversionPicker.selectedRow(inComponent: 1)
        
        let fromTemperatureScale = temperatureScales[fromTemperatureIdx]
        let toTemperatureScale = temperatureScales[toTemperatureIdx]
        
        if let inputValue = inputTextField.text {
            if !inputValue.isEmpty {
                guard let temperatureValue = Double(inputValue) ?? nil
                else {
                    return
                }
                let outputTemperature = fromTemperatureScale.convertTo(temperatureScale: toTemperatureScale, value: temperatureValue)
                outputLabel.text = String(format: "%.2f", (outputTemperature))
            }
            else {
                outputLabel.text = ""
                }
            }
    }
}

