//
//  Bulmaca.swift
//  SatrancTaslari
//
//  Created by Olcay Taner YILDIZ on 1/18/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

class Bulmaca{
    fileprivate var yerlestirilecekYerler : [Kare] = []
    fileprivate var tehditler : [Tehdit] = []
    
    func yerlestirilecekYerEkle(_ yer : Kare){
        yerlestirilecekYerler.append(yer)
    }
    
    func yerlestirilecekYerNo(_ x : Int, y : Int)->Int{
        for i in 0..<yerlestirilecekYerler.count{
            let kare : Kare = yerlestirilecekYerler[i]
            if (kare.x == x && kare.y == y){
                return i
            }
        }
        return -1
    }
    
    func yerlestirilecekYerSayisi()->Int{
        return yerlestirilecekYerler.count
    }
    
    func yerlestirilecekYer(_ pozisyon : Int)->Kare{
        return yerlestirilecekYerler[pozisyon]
    }
    
    func tehditSayisi()->Int{
        return tehditler.count
    }
    
    func tehditEkle(_ tehdit : Tehdit){
        tehditler.append(tehdit)
    }
    
    func tehdit(_ pozisyon : Int)->Tehdit{
        return tehditler[pozisyon]
    }
    
    func sahKontrol(_ cozum : Cozum, x : Int, y:Int)->Int{
        var kim : Int
        for i in -1...1{
            for j in -1...1{
                kim = yerlestirilecekYerNo(x + i, y : y + j)
                if (kim != -1 && cozum.tasAd(kim) == "sah"){
                    return 1
                }
            }
        }
        return 0
    }
    
    func filKontrol(_ cozum : Cozum, x : Int, y : Int)->Int{
        let xArtis : [Int] = [1, 1, -1, -1]
        let yArtis : [Int] = [1, -1, 1, -1]
        var kim, count, a, b : Int
        count = 0
        for j in 0...3{
            for i in 1...7{
                a = x + i * xArtis[j]
                b = y + i * yArtis[j]
                kim = yerlestirilecekYerNo(a, y : b)
                if (kim != -1){
                    if (cozum.tasAd(kim).hasPrefix("fil")){
                        count += 1
                    }else{
                        break
                    }
                }
            }
        }
        return count
    }
    
    func kaleKontrol(_ cozum : Cozum, x : Int, y : Int)->Int{
        let xArtis : [Int] = [1, -1, 0, 0]
        let yArtis : [Int] = [0, 0, 1, -1]
        var kim, count, a, b : Int
        count = 0
        for j in 0...3{
            for i in 1...7{
                a = x + i * xArtis[j]
                b = y + i * yArtis[j]
                kim = yerlestirilecekYerNo(a, y : b)
                if (kim != -1){
                    if (cozum.tasAd(kim).hasPrefix("kale")){
                        count += 1
                    }else{
                        break
                    }
                }
            }
        }
        return count
    }
    
    func vezirKontrol(_ cozum : Cozum, x : Int, y : Int)->Int{
        let xArtis : [Int] = [1, 1, -1, -1, 1, -1, 0, 0]
        let yArtis : [Int] = [1, -1, 1, -1, 0, 0, 1, -1]
        var kim, a, b : Int
        for j in 0...7{
            for i in 1...7{
                a = x + i * xArtis[j]
                b = y + i * yArtis[j]
                kim = yerlestirilecekYerNo(a, y : b)
                if (kim != -1){
                    if (cozum.tasAd(kim) == "vezir"){
                        return 1
                    } else {
                        break
                    }
                }
            }
        }
        return 0
    }
    
    func atKontrol(_ cozum : Cozum, x : Int, y : Int)->Int{
        let xArtis : [Int] = [1, 2, 1, -1, -1, 2, -2, -2]
        let yArtis : [Int] = [-2, -1, 2, 2, -2, 1, 1, -1]
        var kim, a, b, count : Int
        count = 0
        for j in 0...7{
            a = x + xArtis[j]
            b = y + yArtis[j]
            kim = yerlestirilecekYerNo(a, y : b)
            if (kim != -1){
                if (cozum.tasAd(kim).hasPrefix("at")){
                    count += 1
                } else {
                    break
                }
            }
        }
        return count
    }
    
    func sartlariSaglar(_ cozum : Cozum)->Bool{
        var x, y, count : Int
        for i in 0..<tehditler.count{
            let tehdit : Tehdit = tehditler[i]
            x = tehdit.x
            y = tehdit.y
            count = sahKontrol(cozum,  x : x, y : y) + filKontrol(cozum, x : x, y : y) + kaleKontrol(cozum, x : x, y : y) + vezirKontrol(cozum, x : x, y : y) + atKontrol(cozum, x : x, y : y)
            if (count != tehdit.tehditSayisi){
                return false
            }
        }
        return true
    }

    func sartlariSimdilikSaglar(_ cozum : Cozum)->Bool{
        var x, y, count : Int
        for i in 0..<tehditler.count{
            let tehdit : Tehdit = tehditler[i]
            x = tehdit.x
            y = tehdit.y
            count = sahKontrol(cozum,  x : x, y : y) + filKontrol(cozum, x : x, y : y) + kaleKontrol(cozum, x : x, y : y) + vezirKontrol(cozum, x : x, y : y) + atKontrol(cozum, x : x, y : y)
            if (count > tehdit.tehditSayisi){
                return false
            }
        }
        return true
    }
    
}
