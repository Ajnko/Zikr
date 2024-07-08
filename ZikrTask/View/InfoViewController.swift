//
//  InfoViewController.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 02/06/24.
//

import UIKit
import SnapKit

class InfoViewController: UIViewController {
    
    let backgroundImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "backgroundImage")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    let blurView: UIVisualEffectView = {
       let blurview = UIVisualEffectView()
        return blurview
    }()
    
    let blurEffect = UIBlurEffect(style: .light)
    
    let zikrInfoLabel = CustomLabel(
        text: "Абу Ҳурайра розияллоҳу анҳудан ривоят қилинади: Расулуллоҳ соллаллоҳу алайҳи васаллам: «Киши тўшакка ётаётганида кўрпа ва изорини қоқиб ташласин. Чунки унинг орасида нима борлигини билмайди. Сўнг:  بِاسْمِكَ رَبِّي وَضَعْتُ جَنْبِي وَبِكَ أَرْفَعُهُ إِنْ أَمْسَكْتَ نَفْسِي فَارْحَمْهَا وَإِنْ أرْسَلْتَهَا فَاحْفَظْهَا بِمَا تَحْفَظُ بِهِ عِبَادَكَ الصَّالِحِينَ  «Бисмика роббий вазоъту жамбий ва бика арфаъуҳу, ин амсакта нафсий фарҳамҳа ва ин арсалтаҳа фаҳфазҳа бима таҳфазу биҳи ъибадакас солиҳийн», деб айтсин», дедилар. (Маъноси: Эй Раббим, Сенинг исминг билан ётдим ва Сенинг исминг билан тураман. Агар менинг руҳимни олсанг, унга раҳм қил. Агар уни қўйиб юборсанг, худди солиҳ бандаларингни сақлаганингдек, уни ҳам ҳифзу ҳимоянгга ол.)  Имом Бухорий ва Муслим ривоятлари.  Оиша розияллоҳу анҳо айтадилар: «Расулуллоҳ соллаллоҳу алайҳи васаллам тўшакларига ётсалар, қўлларига суфлаб, иккита «Қул аъузу»ни ўқир, сўнг таналарига суртар эдилар».  Имом Бухорий ва Муслим ривоятлари.",
        textColor: .black,
        fontSize: .boldSystemFont(ofSize: 16),
        numberOfLines: 30
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Info"
        view.backgroundColor = .systemBackground
        
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backgroundImage.bringSubviewToFront(scrollView)
        
        scrollView.addSubview(blurView)
        blurView.effect = blurEffect
        blurView.layer.cornerRadius = 15
        blurView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.centerY).multipliedBy(0.001)
            make.width.equalTo(view.snp.width).multipliedBy(1)
            make.height.equalTo(view.snp.height).multipliedBy(1)

        }
        
        blurView.contentView.addSubview(zikrInfoLabel)
        zikrInfoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(blurView.snp.centerY).multipliedBy(0.05)
            make.width.equalTo(blurView.snp.width).multipliedBy(0.95)
            make.height.equalTo(blurView.snp.height).multipliedBy(0.9)
        }
    }
    


}
