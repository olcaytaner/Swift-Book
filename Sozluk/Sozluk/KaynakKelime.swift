//
//  KaynakKelime.swift
//  Sozluk
//
//  Created by Olcay Taner YILDIZ on 1/22/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

class KaynakKelime : Kelime{
    fileprivate var ceviriler : [Ceviri] = []
    
    override init(ad :String){
        super.init(ad: ad)
    }
    
    func ceviriEkle(_ ceviri : Ceviri){
        ceviriler.append(ceviri)
    }
    
    func ceviriSayisi()->Int{
        return ceviriler.count
    }
    
    func ceviri(_ pozisyon : Int)->Ceviri{
        return ceviriler[pozisyon]
    }
}
