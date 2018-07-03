//
//  Kazanc.swift
//  Pisti
//
//  Created by Olcay Taner YILDIZ on 1/18/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

class Kazanc{
    fileprivate var normalKartlar : [Kart] = []
    fileprivate var pistiKartlar : [Kart] = []
    
    func normalEkle(_ kart : Kart){
        normalKartlar.append(kart)
    }
    
    func pistiEkle(_ kart : Kart){
        pistiKartlar.append(kart)
    }
    
    func kartSayisi()->Int{
        return normalKartlar.count + 2 * pistiKartlar.count
    }
    
    func puan()->Int{
      var puan : Int = 0
        for kart in pistiKartlar{
            if (kart.deger == 11){
                puan += 20
            } else {
                puan += 10
            }
        }
        for kart in normalKartlar{
            if (kart.deger == 1 || kart.deger == 11){
                puan += 1
            } else {
                if (kart.deger == 2 && kart.tip == "sinek"){
                    puan += 2
                } else {
                    if (kart.deger == 10 && kart.tip == "karo"){
                        puan += 3
                    }
                }
            }
        }
        return puan
    }
    
}
