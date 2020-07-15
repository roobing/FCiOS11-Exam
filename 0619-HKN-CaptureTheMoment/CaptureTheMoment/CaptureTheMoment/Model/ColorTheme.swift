//
//  ColorTheme.swift
//  CaptureTheMoment
//
//  Created by Doyoung Song on 6/25/20.
//  Copyright © 2020 Doyoung Song. All rights reserved.
//

import UIKit

enum ColorTheme {
    case morning, afternoon, evening, night
}

struct ColorPalette {
    var backgourndColor: UIColor
    var textColor: UIColor
    var menuColor: UIColor
    var upperGradientColor: UIColor
    var lowerGradientColor: UIColor
    var buttonColor: UIColor
    var circleButtonColor: UIColor
    var circleBtnCameraColor: UIColor
    
    func changeColorTheme(colorTheme: ColorTheme) {
    switch colorTheme {
    case .morning:
        HomeController.currentTheme = .morning
        colorPalette.backgourndColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        colorPalette.textColor = #colorLiteral(red: 0.8636735082, green: 0.8400102258, blue: 0.9668851495, alpha: 1)
        colorPalette.menuColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        colorPalette.upperGradientColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        colorPalette.lowerGradientColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        colorPalette.buttonColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        colorPalette.circleButtonColor = #colorLiteral(red: 0.7424319983, green: 0.9849925637, blue: 1, alpha: 1)
        colorPalette.circleBtnCameraColor = #colorLiteral(red: 0.2588235294, green: 0.2823529412, blue: 0.4549019608, alpha: 1)
    case .afternoon:
        HomeController.currentTheme = .afternoon
        colorPalette.backgourndColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        colorPalette.textColor = #colorLiteral(red: 0.8636735082, green: 0.8400102258, blue: 0.9668851495, alpha: 1)
        colorPalette.menuColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        colorPalette.upperGradientColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        colorPalette.lowerGradientColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        colorPalette.buttonColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        colorPalette.circleButtonColor = #colorLiteral(red: 0.6376516223, green: 0.8640954494, blue: 0.6266855001, alpha: 1)
        colorPalette.circleBtnCameraColor = #colorLiteral(red: 0.2588235294, green: 0.2823529412, blue: 0.4549019608, alpha: 1)
    case .evening:
        HomeController.currentTheme = .evening
        colorPalette.backgourndColor = #colorLiteral(red: 0.9906017184, green: 0.3689621091, blue: 0.06245584041, alpha: 1)
        colorPalette.textColor = #colorLiteral(red: 0.8636735082, green: 0.8400102258, blue: 0.9668851495, alpha: 1)
        colorPalette.menuColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        colorPalette.upperGradientColor = #colorLiteral(red: 1, green: 0.4411358833, blue: 0.1435810328, alpha: 1)
        colorPalette.lowerGradientColor = #colorLiteral(red: 0.8946070671, green: 0.3326709867, blue: 0.08993379027, alpha: 1)
        colorPalette.buttonColor = #colorLiteral(red: 0.8636735082, green: 0.8400102258, blue: 0.9668851495, alpha: 1)
        colorPalette.circleButtonColor = #colorLiteral(red: 0.9450637698, green: 0.7285600305, blue: 0.6400149465, alpha: 1)
        colorPalette.circleBtnCameraColor = #colorLiteral(red: 0.2588235294, green: 0.2823529412, blue: 0.4549019608, alpha: 1)
    case .night:
        HomeController.currentTheme = .night
        colorPalette.backgourndColor = #colorLiteral(red: 0.2252208889, green: 0.241878897, blue: 0.3283707201, alpha: 1)
        colorPalette.textColor = #colorLiteral(red: 0.8636735082, green: 0.8400102258, blue: 0.9668851495, alpha: 1)
        colorPalette.menuColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        colorPalette.upperGradientColor = #colorLiteral(red: 0.2588235294, green: 0.2823529412, blue: 0.4549019608, alpha: 1)
        colorPalette.lowerGradientColor = #colorLiteral(red: 0.2307544053, green: 0.2378650904, blue: 0.3159170151, alpha: 1)
        colorPalette.buttonColor = #colorLiteral(red: 0.8636735082, green: 0.8400102258, blue: 0.9668851495, alpha: 1)
        colorPalette.circleButtonColor = #colorLiteral(red: 0.862745098, green: 0.8392156863, blue: 0.968627451, alpha: 1)
        colorPalette.circleBtnCameraColor = #colorLiteral(red: 0.2588235294, green: 0.2823529412, blue: 0.4549019608, alpha: 1)
        }
    }
}

var colorPalette = ColorPalette(
    backgourndColor: #colorLiteral(red: 0.2252208889, green: 0.241878897, blue: 0.3283707201, alpha: 1),
    textColor: #colorLiteral(red: 0.8636735082, green: 0.8400102258, blue: 0.9668851495, alpha: 1),
    menuColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
    upperGradientColor: #colorLiteral(red: 0.2588235294, green: 0.2823529412, blue: 0.4549019608, alpha: 1),
    lowerGradientColor: #colorLiteral(red: 0.2307544053, green: 0.2378650904, blue: 0.3159170151, alpha: 1),
    buttonColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
    circleButtonColor: #colorLiteral(red: 0.862745098, green: 0.8392156863, blue: 0.968627451, alpha: 1),
    circleBtnCameraColor: #colorLiteral(red: 0.2588235294, green: 0.2823529412, blue: 0.4549019608, alpha: 1)
)
