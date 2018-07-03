//
//  SozlukKelime.swift
//  Sozluk
//
//  Created by Olcay Taner YILDIZ on 1/22/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

class SozlukKelime : Kelime{
    var sinif : String = ""
    var koken : String = ""
    fileprivate var anlamlar : [Anlam] = []
    
    override init(ad :String){
        super.init(ad: ad)
    }
    
    func anlamEkle(_ anlam : Anlam){
        anlamlar.append(anlam)
    }
    
    func anlamSayisi()->Int{
        return anlamlar.count
    }
    
    func anlam(_ pozisyon : Int)->Anlam{
        return anlamlar[pozisyon]
    }
}
