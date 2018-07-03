//
//  ViewController.swift
//  Piramit
//
//  Created by Olcay Taner YILDIZ on 1/9/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit
import Darwin

class Piramit: UIViewController {

    @IBOutlet var ekran: Ekran!
    fileprivate var bulmacalar : [Bulmaca] = []

    override func viewDidLoad() {
        var pozisyon : Int
        super.viewDidLoad()
        let bulmacaBilgileri : [String] = ["443252145336141522663", "234524435626143614625", "161524246313452326215", "355424315665631243245", "653634542621351325265", "543236612135654465432", "445385279314268683141725276595138379834941283", "345342468929768161215485464767167583529398619", "233154981265474421359918793858356165737438971", "134925548326192374564412375353491475182356918"]
        for i in 0..<bulmacaBilgileri.count{
            bulmacalar.append(Bulmaca(bulmacaBilgisi: bulmacaBilgileri[i]))
        }
        pozisyon = Int(arc4random_uniform(UInt32(bulmacalar.count)))
        ekran.bulmaca = bulmacalar[pozisyon]
        if let kareSayisi = ekran.bulmaca?.buyukluk{
            ekran.hucreGenislik = UIScreen.main.bounds.size.width / CGFloat(kareSayisi + 2)
        }
        ekran.setNeedsDisplay()
    }

    @IBAction func hucreTikla(_ sender: UITapGestureRecognizer) {
        let nokta : CGPoint = sender.location(in: self.view)
        var alan : CGRect
        var x, y, solSira : CGFloat
        if let kareSayisi = ekran.bulmaca?.buyukluk{
            for i in 0..<kareSayisi{
                for j in 0...i{
                    solSira = CGFloat(kareSayisi - i + 1 + 2 * j) / 2.0
                    x = solSira * ekran.hucreGenislik
                    y = CGFloat(i + 1) * ekran.hucreGenislik
                    alan = CGRect(x: x, y: y, width: ekran.hucreGenislik, height: ekran.hucreGenislik)
                    if (nokta.x >= alan.origin.x && nokta.x <= alan.origin.x + alan.size.width &&
                        nokta.y >= alan.origin.y && nokta.y <= alan.origin.y + alan.size.height){
                            ekran.bulmaca?.oyna(i, deger:j)
                            ekran.setNeedsDisplay()
                            return
                    }
                }
            }
        }
    }

}

