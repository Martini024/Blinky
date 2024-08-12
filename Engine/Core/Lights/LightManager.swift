import MetalKit

class LightManager {
    private var _lightObjects: [LightObject] = []
    private var _lightData: [LightData] = []
    
    func addLightObject(_ lightObject: LightObject) {
        self._lightObjects.append(lightObject)
        self._lightData.append(lightObject.lightData)
    }
    
    private func gatherLightData() -> [LightData] {
        var result: [LightData] = []
        for _lightObject in _lightObjects {
            result.append(_lightObject.lightData)
        }
        return result
    }
    
    func setLightData(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        var lightDatas = gatherLightData()
        var lightCount = lightDatas.count
        renderCommandEncoder.setFragmentBytes(&lightCount, length: Int32.size, index: 2)
        if (lightCount > 0) {
            renderCommandEncoder.setFragmentBytes(&lightDatas, length: LightData.stride(lightCount), index: 3)
        } else {
            renderCommandEncoder.setFragmentBytes(&lightDatas, length: LightData.stride(), index: 3)
        }
    }
}
