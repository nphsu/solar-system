//
//  Earth.swift
//  SolarSystem
//
//  Created by 小池駿平 on 2017/10/28.
//  Copyright © 2017年 小池駿平. All rights reserved.
//

import Foundation
import ARKit

class Earth: Planet {
    
    let size = CGFloat(0.05) // enumへ
    let distance = Float(0.9) // enumへ
    let rotationSpeed = Double(20) // enumへ
    
    func create(x: Float, y: Float, z: Float) -> SCNNode {
        let earth = super.create(diffuse: #imageLiteral(resourceName: "Earth"), radius: size, distance: distance, rotationSpeed: rotationSpeed, x: x, y: y, z: z)
        let earthMoon = EarthMoon().create(x: distance, y: 0, z: 0)
        earth.addChildNode(earthMoon)
        return earth
    }
}
