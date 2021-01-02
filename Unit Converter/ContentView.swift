//
//  ContentView.swift
//  Unit Converter
//
//  Created by Michał Derej on 30/12/2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputNumber = ""
    @State private var conversionType = 0
    @State private var unitInput = 0
    @State private var unitOutput = 0
    
    let options = ["Temperature", "Length", "Time", "Volume"]
    let temperature = ["Celsius", "Fahrenheit", "Kelvin"]
    let length = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]
    let time = ["Seconds", "Minutes", "Hours", "Days"]
    let volume = ["Mililiters", "Liters", "Cups", "Pints", "Gallons"]
    
    var convertedValue: Double {
        
        let convertedValue = inputNumber.replacingOccurrences(of: ",", with: ".")
        let inputValue = Double(convertedValue) ?? 0
        var basicValue: Double
        
        switch(conversionType) {
        
        // Temperature
        case 0:
            
            // 0 == Celsius, 1 == Fahrenheit, 2 == Kelvin
            
            if (unitInput == 0) {
                basicValue = inputValue
            } else if (unitInput == 1) {
                basicValue = (inputValue - 32) * 5 / 9
            } else {
                basicValue = inputValue - 273.15
            }
            
            if (unitOutput == 0) {
                return basicValue
            } else if (unitOutput == 1) {
                return (basicValue * 9 / 5) + 32
            }
            
            return basicValue + 273.15
         
        // Length
        case 1:
            
            // 0 = meters, 1 = kilometers, 2 == feet, 3 == yards, 4 == miles
            
            if (unitInput == 0) {
                basicValue = inputValue
            } else if (unitInput == 1) {
                basicValue = inputValue * 1000
            } else if (unitInput == 2) {
                basicValue = inputValue * 0.3048
            } else if (unitInput == 3) {
                basicValue = inputValue * 0.9144
            } else {
                basicValue = inputValue * 1609.344
            }
            
            if (unitOutput == 0) {
                return basicValue
            } else if (unitOutput == 1) {
                return basicValue / 1000
            } else if (unitOutput == 2) {
                return basicValue * 3.2808399
            } else if (unitOutput == 3) {
                return basicValue * 1.0936133
            }
            
            return basicValue * 0.000621371192
           
        // Time
        case 2:
            
            // 0 == seconds, 1 == minutes, 2 == hours, 3 == days
            
            if (unitInput == 0) {
                basicValue = inputValue
            } else if (unitInput == 1) {
                basicValue = inputValue * 60
            } else if (unitInput == 2) {
                basicValue = inputValue * 3600
            } else {
                basicValue = inputValue * 24 * 3600
            }
            
            if (unitOutput == 0) {
                return basicValue
            } else if (unitOutput == 1) {
                return basicValue / 60
            } else if (unitOutput == 2) {
                return basicValue / 3600
            }
            
            return basicValue / 86400
        
        // Volume
        default:
            
            // 0 == mililiters, 1 == liters, 2 == cups (250 ml), 3 == pints, 4 == gallons
            
            if (unitInput == 0) {
                basicValue = inputValue
            } else if (unitInput == 1) {
                basicValue = inputValue * 1000
            } else if (unitInput == 2) {
                basicValue = inputValue * 250
            } else if (unitInput == 3) {
                basicValue = inputValue * 473.176473
            } else {
                basicValue = inputValue * 3785.41178
            }
            
            if (unitOutput == 0) {
                return basicValue
            } else if (unitOutput == 1) {
                return basicValue / 1000
            } else if (unitOutput == 2) {
                return basicValue / 250
            } else if (unitOutput == 3) {
                return basicValue * 0.00211337642
            }
            
            return basicValue * 0.000264172052
        
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    TextField("Number to convert", text: $inputNumber)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Select conversion type")) {
                    Picker("Conversion type", selection: $conversionType) {
                        ForEach(0 ..< options.count) {
                            Text("\(self.options[$0])")
                        }
                    }
                    
                }
                
                Section(header: Text("Select input units")) {
                    
                    Picker("Input unit", selection: $unitInput) {
                        
                        switch(conversionType) {
                        case 0:
                            ForEach(0 ..< temperature.count) {
                                Text("\(self.temperature[$0])")
                            }
                        case 1:
                            ForEach(0 ..< length.count) {
                                Text("\(self.length[$0])")
                            }
                        case 2:
                            ForEach(0 ..< time.count) {
                                Text("\(self.time[$0])")
                            }
                        default:
                            ForEach(0 ..< volume.count) {
                                Text("\(self.volume[$0])")
                            }
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                }
                
                Section(header: Text("Select output units")) {
                    
                    Picker("Output unit", selection: $unitOutput) {
                        
                        if (conversionType == 0) {
                            ForEach(0 ..< temperature.count) {
                                Text("\(self.temperature[$0])")
                            }
                        } else if (conversionType == 1) {
                            ForEach(0 ..< length.count) {
                                Text("\(self.length[$0])")
                            }
                        } else if (conversionType == 2) {
                            ForEach(0 ..< time.count) {
                                Text("\(self.time[$0])")
                            }
                        } else {
                            ForEach(0 ..< volume.count) {
                                Text("\(self.volume[$0])")
                            }
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                }
                
                Section(header: Text("Converted value")) {
                    Text("\(convertedValue, specifier: "%.5f")")
                }
                
            }
            .navigationBarTitle("Unit Converter")
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
