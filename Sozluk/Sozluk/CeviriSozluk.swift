//
//  CeviriSozluk.swift
//  Sozluk
//
//  Created by Olcay Taner YILDIZ on 1/22/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class CeviriSozluk : NSObject, XMLParserDelegate{
    fileprivate var kelimeler : [KaynakKelime] = []
    fileprivate var cozumleyici : XMLParser
    fileprivate var kelime : KaynakKelime?
    fileprivate var anlamSinif : String = ""
    fileprivate var ceviriSinif : String = ""
    fileprivate var deger : String = ""
    
    init (dosyaAd : String){
        var dosyaIcerik : Data
        var dosyaAdi : String
        dosyaAdi = Bundle.main.path(forResource: dosyaAd, ofType: "xml")!
        dosyaIcerik = try! Data(contentsOf: URL(fileURLWithPath: dosyaAdi))
        cozumleyici = XMLParser(data: dosyaIcerik)
        super.init()
        cozumleyici.delegate = self
        cozumleyici.parse()
    }
    
    func kelimeAra(_ arananKelime : String)->[KaynakKelime]{
        var sonucListe : [KaynakKelime] = []
        for kelime in kelimeler{
            if (kelime.ad == arananKelime){
                sonucListe.append(kelime)
            }
        }
        return sonucListe
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        var ad : String
        if (elementName == "word"){
            ad = attributeDict["name"]! as String
            kelime = KaynakKelime(ad: ad)
            ceviriSinif = ""
            deger = ""
        } else {
            if (elementName == "lexical") {
                ceviriSinif = attributeDict["class"]! as String
                deger = ""
            } else {
                if (elementName == "meaning"){
                    if let lexclass:AnyObject = attributeDict["class"] as AnyObject?{
                        anlamSinif = String(lexclass as! NSString)
                    }
                    deger = ""
                }
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String){
        deger = deger + string
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        var anlam : Anlam
        var ceviri : Ceviri
        if (elementName == "lexicon"){
            return
        } else {
            if (elementName == "word"){
                kelimeler.append(kelime!)
            } else {
                if (elementName == "lexical"){
                    ceviriSinif = ""
                } else {
                    if (elementName == "meaning"){
                        if (!anlamSinif.isEmpty){
                            anlam = Anlam(sinif: anlamSinif, anlam:deger)
                        } else {
                            anlam = Anlam(anlam: deger)
                        }
                        if (!ceviriSinif.isEmpty){
                            ceviri = Ceviri(sinif: ceviriSinif, anlam:anlam)
                        } else {
                            ceviri = Ceviri(anlam : anlam)
                        }
                        if let kelime = kelime{
                            kelime.ceviriEkle(ceviri)
                        }
                    }
                }
            }
        }
    }
}

