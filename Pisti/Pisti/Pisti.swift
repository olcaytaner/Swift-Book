//
//  ViewController.swift
//  Pisti
//
//  Created by Olcay Taner YILDIZ on 1/15/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class Pisti: UIViewController, CAAnimationDelegate {

    @IBOutlet var kapaliKartlar: [UIImageView]!
    @IBOutlet var bilgisayarKartlar: [UIImageView]!
    @IBOutlet var kartlar: [UIImageView]!
    @IBOutlet weak var ortaKart: UIImageView!
    fileprivate var animasyonKart : UIImageView?
    fileprivate var deste : Deste = Deste()
    fileprivate var orta : Orta = Orta()
    fileprivate var insan : El?
    fileprivate var bilgisayar : El?
    fileprivate var insanKazanc : Kazanc = Kazanc()
    fileprivate var bilgisayarKazanc : Kazanc = Kazanc()
    fileprivate var tur : Int = 0
    fileprivate var hamle : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        oyunaBasla()
    }

    @IBAction func kartTikla(_ sender: UITapGestureRecognizer) {
        let nokta : CGPoint = sender.location(in: self.view)
        if let secilenKart = hangiKart(nokta){
            if let insan = insan{
                if (insan.oynandiMi(secilenKart.tag)){
                    return
                }
            }
            animasyonKart = secilenKart
            animasyon(secilenKart, ad:"insan")
        }
    }
    
    func ortayiGoster(){
        for view in kapaliKartlar{
            if (view.tag > orta.kartSayisi() + 7){
                view.isHidden = true
            } else {
                view.isHidden = false
            }
        }
        self.view.bringSubview(toFront: ortaKart)
    }
    
    func animasyon(_ kart:UIImageView, ad:String){
        let animasyon : CABasicAnimation = CABasicAnimation(keyPath: "position")
        animasyon.isAdditive = true
        animasyon.fromValue = NSValue(cgPoint: CGPoint.zero)
        animasyon.toValue = NSValue(cgPoint:CGPoint(x: ortaKart.frame.origin.x - kart.frame.origin.x, y: ortaKart.frame.origin.y - kart.frame.origin.y))
        animasyon.autoreverses = false
        animasyon.duration = 1
        animasyon.repeatCount = 1
        animasyon.delegate = self
        kart.layer.add(animasyon, forKey:ad)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let animasyonKart = animasyonKart{
            animasyonKart.isHidden = true
            if (animasyonKart.tag < 4){
                if let insan = insan{
                    oyna(insan, kazanc:insanKazanc, kartNo:animasyonKart.tag)
                    bilgisayarDusun()
                }
            } else {
                animasyonKart.image = UIImage(named: "bos.png")
                if let bilgisayar = bilgisayar{
                    oyna(bilgisayar, kazanc:bilgisayarKazanc, kartNo:animasyonKart.tag - 4)
                    oyunuDevamEttir()
                }
            }
        }
    }
    
    func oyna(_ el : El, kazanc : Kazanc, kartNo : Int){
        let kart : Kart = el.oyna(kartNo)
        orta.kartEkle(kart)
        if (orta.kazancVarMi()){
            orta.kazancaGonder(kazanc)
            ortayiGoster()
            ortaKart.image = nil
        } else {
            ortayiGoster()
            if let ustKart = orta.ustKart(){
                ortaKart.image = UIImage(named: ustKart.description() + ".png")
            }
        }
    }
    
    func oyunBitti(){
        var bilgisayarPuan : Int = bilgisayarKazanc.puan()
        var insanPuan : Int = insanKazanc.puan()
        if (bilgisayarKazanc.kartSayisi() > insanKazanc.kartSayisi()){
            bilgisayarPuan += 3
        } else {
            insanPuan += 3
        }
        let mesaj : String = String(format:"Bilgisayar:%d İnsan:%d", bilgisayarPuan, insanPuan)
        let alarm : UIAlertView = UIAlertView(title:"Oyun Bitti!", message:mesaj, delegate:self, cancelButtonTitle:"Vazgec")
        alarm.show()
    }
    
    func oyunuDevamEttir(){
        hamle += 1
        if (hamle == 4){
            hamle = 0
            tur += 1
            if (tur < 6){
                turaBasla()
                ortayiGoster()
            } else {
                oyunBitti()
            }
        }
    }
    
    func ayniKagitVarMi()->Int{
        if let bilgisayar = bilgisayar{
            if let ustKart = orta.ustKart(){
                for i in 0...3{
                    if (!bilgisayar.oynandiMi(i) && bilgisayar.kartGetir(i).deger == ustKart.deger){
                        return i
                    }
                }
            }
        }
        return -1
    }
    
    func valeVarMi()->Int{
        if let bilgisayar = bilgisayar{
            for i in 0...3{
                if (!bilgisayar.oynandiMi(i) && bilgisayar.kartGetir(i).deger == 11){
                    return i
                }
            }
        }
        return -1
    }
    
    func rastgeleOyna()->Int{
        var kart : Int = Int(arc4random_uniform(4))
        if let bilgisayar = bilgisayar{
            while (bilgisayar.oynandiMi(kart)){
                kart = Int(arc4random_uniform(4))
            }
        }
        return kart
    }
    
    func bilgisayarDusun(){
        var secilenKart : Int = -1
        if (orta.ustKart() != nil){
            secilenKart = ayniKagitVarMi()
            if (secilenKart == -1){
                secilenKart = valeVarMi()
            }
        }
        if (secilenKart == -1){
            secilenKart = rastgeleOyna()
        }
        for view in bilgisayarKartlar{
            if (view.tag == secilenKart + 4){
                if let bilgisayar = bilgisayar{
                    view.image = UIImage(named: bilgisayar.kartGetir(view.tag - 4).description() + ".png")
                    animasyonKart = view
                    animasyon(view, ad:"bilgisayar")
                    break
                }
            }
        }
    }
    
    func turaBasla(){
        insan = deste.elDagit()
        bilgisayar = deste.elDagit()
        for i in 0...3{
            if let insan = insan{
                kartlar[i].image = UIImage(named: insan.kartGetir(kartlar[i].tag).description() + ".png")
                kartlar[i].isHidden = false
            }
        }
        if let ustKart = orta.ustKart(){
            ortaKart.image = UIImage(named: ustKart.description() + ".png")
        } else {
            ortaKart.image = nil
        }
        for i in 0...3{
            bilgisayarKartlar[i].isHidden = false
        }
        hamle = 0
    }
    
    func oyunaBasla(){
        tur = 0
        deste = Deste()
        orta = Orta()
        insanKazanc = Kazanc()
        bilgisayarKazanc = Kazanc()
        deste.ortaDagit(orta)
        turaBasla()
        ortayiGoster()
    }
    
    func bolgeninIcinde(_ kart : UIImageView, aNokta : CGPoint)->Bool{
        if (aNokta.x > kart.frame.origin.x && aNokta.x < kart.frame.origin.x + kart.frame.size.width &&
            aNokta.y > kart.frame.origin.y && aNokta.y < kart.frame.origin.y + kart.frame.size.height){
                return true
        } else {
            return false
        }
    }
    
    func hangiKart(_ nokta : CGPoint)->UIImageView?{
        for view in kartlar{
            if (bolgeninIcinde(view, aNokta:nokta)){
                return view
            }
        }
        return nil
    }
    
}

