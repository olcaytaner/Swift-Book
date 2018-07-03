//
//  Deste.swift
//  Pisti
//
//  Created by Olcay Taner YILDIZ on 1/18/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import Foundation

class Deste{
    fileprivate var kartlar : [Kart] = []
    
    init(){
        kartlariDagit()
        kartlariKaristir()
    }
    
    func kartlariDagit(){
        var tip : String
        var kart : Kart
        for i in 0...3{
            switch (i){
                case 0:
                    tip = "karo"
                case 1:
                    tip = "kupa"
                case 2:
                    tip = "sinek"
                case 3:
                    tip = "maca"
                default:
                    tip = ""
            }
            for j in 1...13{
                kart = Kart(tip:tip, deger:j)
                kartlar.append(kart)
            }
        }
    }
    
    func kartlariKaristir(){
        var kalan , degistirilen : Int
        var geciciKart : Kart
        for i in 0...51{
            kalan = 52 - i
            degistirilen = i + Int(arc4random_uniform(UInt32(kalan)))
            geciciKart = kartlar[i]
            kartlar[i] = kartlar[degistirilen]
            kartlar[degistirilen] = geciciKart
        }
    }
    
    func elDagit()->El{
        var el : El
        var count : Int
        count = kartlar.count
        el = El(kart1: kartlar[count - 1], kart2: kartlar[count - 2], kart3: kartlar[count - 3], kart4: kartlar[count - 4])
        for _ in 0...3{
            kartlar.removeLast()
        }
        return el
    }
    
    func ortaDagit(_ orta : Orta){
        for _ in 0...3{
            orta.kartEkle(kartlar[kartlar.count - 1])
            kartlar.removeLast()
        }
    }
    
}
