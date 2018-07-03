//
//  El.swift
//  Pisti
//
//  Created by Olcay Taner YILDIZ on 1/18/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

class El{
    fileprivate var kartlar: [Kart] = []
    fileprivate var oynandiMi : [Bool] = []
    
    init(kart1: Kart, kart2: Kart, kart3: Kart, kart4: Kart){
        kartlar.append(kart1)
        kartlar.append(kart2)
        kartlar.append(kart3)
        kartlar.append(kart4)
        for _ in 0...3{
            oynandiMi.append(false)
        }
    }
    
    func oyna(_ pozisyon : Int)->Kart{
        oynandiMi[pozisyon] = true
        return kartlar[pozisyon]
    }
    
    func kartGetir(_ pozisyon : Int)->Kart{
        return kartlar[pozisyon]
    }
    
    func oynandiMi(_ pozisyon : Int)->Bool{
        return oynandiMi[pozisyon]
    }
}
