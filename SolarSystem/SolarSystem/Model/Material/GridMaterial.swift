//
//  GridMaterial.swift
//  SolarSystem
//
//  Created by 小池駿平 on 2017/11/04.
//  Copyright © 2017年 小池駿平. All rights reserved.
//

import Foundation
import ARKit

struct GridMaterial {
    
    func create() -> SCNMaterial {
        let gridMaterial = SCNMaterial()
        gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
        return gridMaterial
    }
}
