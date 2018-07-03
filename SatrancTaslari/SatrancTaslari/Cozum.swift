//
//  Cozum.swift
//  SatrancTaslari
//
//  Created by Olcay Taner YILDIZ on 1/18/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

class Cozum{
    fileprivate var taslar : [Tas] = []
    let tumTaslar : [Tas] = [Tas(ad: "sah"), Tas(ad: "vezir"), Tas(ad: "kale1"), Tas(ad: "kale2"), Tas(ad: "fil1"), Tas(ad: "fil2"), Tas(ad: "at1"), Tas(ad: "at2")]
    
    func tasAd(_ pozisyon : Int)->String{
        if (pozisyon >= 0 && pozisyon < taslar.count){
            return taslar[pozisyon].ad
        }else{
            return "bos"
        }
    }
    
    func tasNo(_ pozisyon : Int)->Int{
        for i in 0..<tumTaslar.count{
            if (taslar[pozisyon].ad == tumTaslar[i].ad){
                return i
            }
        }
        return -1
    }
    
    func tasSayisi()->Int{
        return taslar.count
    }
    
    func tasEkle(_ tas : Tas){
        taslar.append(tas)
    }
    
    func tasNoIleEkle(_ tas : Int){
        if (tas >= 0 && tas < 8){
            taslar.append(tumTaslar[tas])
        }
    }
    
    func tasCikar(){
        taslar.removeLast()
    }
    
    func adaylariOlustur()->[Tas]{
        var bulundu : Bool
        var aday : [Tas] = []
        for olasiTas in tumTaslar{
            bulundu = false
            for tas in taslar{
                if (tas.ad == olasiTas.ad){
                    bulundu = true
                    break
                }
            }
            if (!bulundu){
                aday.append(olasiTas)
            }
        }
        return aday
    }

}
