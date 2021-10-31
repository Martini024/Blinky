//
//  LightManager.swift
//  Game Engine
//
//  Created by Martini Reinherz on 31/10/21.
//

import MetalKit

class LightManager {
    private var _lightObjects: [LightObject] = []
    private var _lightData: [LightData] = []
    
    func addLightObject(_ lightObject: LightObject) {
        self._lightObjects.append(lightObject)
        self._lightData.append(lightObject.lightData)
    }
    
    func setLightData(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setFragmentBytes(&_lightData,
                                              length: LightData.size(_lightData.count),
                                              index: 2)
    }
}
