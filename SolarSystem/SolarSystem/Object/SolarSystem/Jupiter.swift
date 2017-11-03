//
//  Jupiter.swift
//  SolarSystem
//
//  Created by 小池駿平 on 2017/11/03.
//  Copyright © 2017年 小池駿平. All rights reserved.
//

import Foundation
import ARKit

class Jupiter: Planet {
    
    let size = CGFloat(0.15) // enumへ
    let distance = Float(1.5) // enumへ
    let rotationSpeed = Double(30) // enumへ
    
    func create(x: Float, y: Float, z: Float) -> SCNNode {
        return super.create(diffuse: #imageLiteral(resourceName: "Jupiter"), radius: size, distance: distance, rotationSpeed: Double(rotationSpeed), x: x, y: y, z: z)
    }
}
