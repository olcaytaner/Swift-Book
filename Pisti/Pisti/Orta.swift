//
//  Orta.swift
//  Pisti
//
//  Created by Olcay Taner YILDIZ on 1/18/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

class Orta{
    fileprivate var kartlar : [Kart] = []
    
    func ustKart()->Kart?{
        if (kartlar.count > 0){
            return kartlar[kartlar.count - 1]
        }
        return nil
    }
    
    func kartEkle(_ kart : Kart){
        kartlar.append(kart)
    }
    
    func kartSayisi()->Int{
        return kartlar.count
    }
    
    func kazancVarMi()->Bool{
        var ustKart, altKart : Kart
        if (kartlar.count >= 2){
            ustKart = kartlar[kartlar.count - 1]
            altKart = kartlar[kartlar.count - 2]
            if (ustKart.deger == altKart.deger || ustKart.deger == 11){
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    func kazancaGonder(_ kazanc : Kazanc){
        if (kartlar.count == 2){
            if let kart = ustKart(){
                kazanc.pistiEkle(kart)
            }
        } else {
            for kart in kartlar{
                kazanc.normalEkle(kart)
            }
        }
        kartlar.removeAll(keepingCapacity: false)
    }
}
