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
        case .celsius where scale == .fahrenheit:
            result = inputValue * 1.8 + 32
        case .celsius where scale == .kelvin:
            result = inputValue + 273.15
        case .fahrenheit where scale == .celsius:
            result = (inputValue - 32) / 1.8
        case .fahrenheit where scale == .kelvin:
            result = (inputValue + 459.67) / 1.8
        case .kelvin where scale == .celsius:
            result = inputValue - 273.15
        case .kelvin where scale == .fahrenheit:
            result = inputValue * 1.8 - 459.67
        default: result = inputValue
        }
        return result
    }
    
}

class ViewController: UIViewController {
    @IBOutlet weak var conversionPicker: UIPickerView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    
    let temperatureScales = Temperature.allCases
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conversionPicker.delegate = self
        conversionPicker.dataSource = self
    }
    
    @IBAction func temperatureInputChanged(_ sender: Any) {
        setConvertionValue()
    }
    
    
    func setConvertionValue() {
        let fromTemperatureIdx = conversionPicker.selectedRow(inComponent: 0)
        let toTemperatureIdx = conversionPicker.selectedRow(inComponent: 1)
        
        let fromTemperatureScale = temperatureScales[fromTemperatureIdx]
        let toTemperatureScale = temperatureScales[toTemperatureIdx]
        
        guard let inputValue = inputTextField.text, !inputValue.isEmpty, let temperatureValue = Double(inputValue) else {
            outputLabel.text = ""
            return
        }
        
        let outputTemperature = fromTemperatureScale.convertTo(temperatureScale: toTemperatureScale, value: temperatureValue)
        outputLabel.text = String(format: "%.2f", (outputTemperature))
    }
    
}
extension ViewController: UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        temperatureScales.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
}

extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return temperatureScales[row].description()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component:Int) {
        setConvertionValue()
    }
}





