//
//  MainViewController.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 22/05/24.
//

import UIKit
import SnapKit
import EMTNeumorphicView

class MainViewController: UIViewController, GroupViewControllerDelegate {
    
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
         image.image = UIImage(named: "backgroundImage")
         image.contentMode = .scaleAspectFill
         return image
    }()
    
    let segmentControler = UISegmentedControl()
    let segmentNeomView  = EMTNeumorphicView()

    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.scrollDirection = .vertical
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(GroupCollectionViewCell.self, forCellWithReuseIdentifier: GroupCollectionViewCell.identifier)
        collectionview.register(PersonalCollectionViewCell.self, forCellWithReuseIdentifier: PersonalCollectionViewCell.identifier)
        collectionview.backgroundColor = .clear
        return collectionview
    }()
    
    let addButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .darkMode
        button.backgroundColor = .clear
//        button.layer.shadowColor = UIColor.black.cgColor
//        button.layer.shadowOpacity = 0.5
//        button.layer.shadowOffset = CGSize(width: 0, height: 3)
//        button.layer.shadowRadius = 4
//        button.layer.cornerRadius = 30
        return button
    }()
    
    let blurView: UIVisualEffectView = {
       let blurview = UIVisualEffectView()
        return blurview
    }()
    //blur effect
    let blurEffect = UIBlurEffect(style: .light)
    
    let groupZikrData = ["Item 1", "Item 2", "Item 3", "Item 1", "Item 1", "Item 1", "Item 1"]
    let myZikrData = ["My Item 1", "My Item 2", "My Item 3", "My Item 1", "My Item 1", "My Item 1", "My Item 1", "My Item 1"]
    
    var groups: [Group] = []

    
    
    weak var sectionSegmentOfFetch: UISegmentedControl!
    weak var sectionCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "moon"), style: .plain, target: self, action: nil)
        
        title = "Zikr"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        //call methods
        addItemsToView()
        setConstraintToItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        segmentControler.selectedSegmentIndex = 0
        collectionView.reloadData()

    }
    
    //Method addItemsToView
    private func addItemsToView() {
        //to view
        view.addSubview(backgroundImage)
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.addSubview(segmentNeomView)
        segmentNeomView.addSubview(segmentControler)
        view.addSubview(collectionView)
        backgroundImage.bringSubviewToFront(segmentNeomView)
        backgroundImage.bringSubviewToFront(collectionView)
    }
    
    //Method setConstraintToItems
    private func setConstraintToItems() {
    
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //segmentNeomView
        segmentNeomView.neumorphicLayer?.elementBackgroundColor = UIColor.black.cgColor
        segmentNeomView.neumorphicLayer?.cornerRadius = 12
        segmentNeomView.neumorphicLayer?.depthType = .convex
        segmentNeomView.neumorphicLayer?.elementDepth = 123
        segmentNeomView.layer.shadowColor = UIColor.black.cgColor
        segmentNeomView.layer.shadowOpacity = 0.5
        segmentNeomView.layer.shadowOffset = CGSize(width: 0, height: 3)
        segmentNeomView.layer.shadowRadius = 4
        segmentNeomView.snp.makeConstraints { make in
            print(view.bounds.height , view.bounds.width)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.centerY).multipliedBy(0.26)
            make.width.equalTo(view.snp.width).multipliedBy(0.89)
            make.height.equalTo(view.snp.height).multipliedBy(0.065)
        }
        
        //segmentControler
        let font = UIFont(name: "Exo 2", size: 40)
        segmentControler.setTitleTextAttributes([NSAttributedString.Key.font: font as Any], for: .normal)
        segmentControler.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.textColor], for: .selected)
        segmentControler.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        segmentControler.selectedSegmentTintColor = #colorLiteral(red: 0.785556972, green: 0.8004897833, blue: 0.7743472457, alpha: 1)
        segmentControler.layer.cornerRadius = 12
        segmentControler.layer.masksToBounds = true
        segmentControler.backgroundColor = .darkMode
        segmentControler.insertSegment(withTitle:"Guruh zikr", at: 0, animated: true)
        segmentControler.setImage(UIImage(systemName: "person.3"), forSegmentAt: 0)
        segmentControler.insertSegment(withTitle:  "Mening zikrim", at: 1, animated: true)
        segmentControler.setImage(UIImage(systemName: "person"), forSegmentAt: 1)
        
        segmentControler.setContentPositionAdjustment(UIOffset(horizontal: -30, vertical: 0), forSegmentType: .any, barMetrics: .default)
        
        segmentControler.addTarget(self, action: #selector(segmentedControl(_:)), for: .valueChanged)
        
        segmentControler.snp.makeConstraints { make in
            
            make.edges.equalToSuperview()
        }
        self.sectionSegmentOfFetch = segmentControler
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentNeomView.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
        
        collectionView.addSubview(blurView)
        blurView.effect = blurEffect
        blurView.clipsToBounds = true
        blurView.layer.cornerRadius = 30
        blurView.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-45)
            make.right.equalTo(view.snp.right).offset(-15)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        collectionView.bringSubviewToFront(blurView)
        
        blurView.contentView.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    
    //MARK: - Segment Controller
    
    @objc func segmentedControl(_ sender:UISegmentedControl) {
        collectionView.reloadData()
    }
    
    @objc func addButtonTapped() {
        let vc = AddGroupViewController()
        vc.delegate = self
        let navVC = UINavigationController(rootViewController: vc)
        
        if let sheet = navVC.sheetPresentationController {
            sheet.preferredCornerRadius = 40
            sheet.detents = [.custom(resolver: { context in
                0.85 * context.maximumDetentValue
              })]
            sheet.largestUndimmedDetentIdentifier = .large
            sheet.prefersGrabberVisible = true
            sheet.accessibilityRespondsToUserInteraction = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
        }
        navigationController?.present(navVC, animated: true)
        print("tap")
        
    }
    
    //MARK: - Protocol Method
    
    func didAddGroup(_ group: Group) {
        groups.append(group)
        collectionView.reloadData()
    }
    
    //MARK: - Shows member list for each group
    
    @objc func showMembersList() {
        let vc = MembersListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch segmentControler.selectedSegmentIndex {
            
        case 0 : return groups.count
        case 1 : return myZikrData.count
        default:
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch segmentControler.selectedSegmentIndex {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupCollectionViewCell.identifier, for: indexPath) as! GroupCollectionViewCell
            cell.backgroundColor = .clear
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOpacity = 0.5
            cell.layer.shadowOffset = CGSize(width: 0, height: 3)
            cell.layer.shadowRadius = 5
            cell.layer.cornerRadius = 15
            let group = groups[indexPath.item]
            cell.groupNameLabel.text = group.name
            cell.zikrCountLabel.text = "Count: \(group.purpose)"
            cell.groupZikrNameLabel.text = group.zikrName
            
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonalCollectionViewCell.identifier, for: indexPath) as! PersonalCollectionViewCell
            cell.backgroundColor = .clear
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOpacity = 0.5
            cell.layer.shadowOffset = CGSize(width: 0, height: 3)
            cell.layer.shadowRadius = 5
            cell.layer.cornerRadius = 15
            return cell
        default:
            break
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width) - 40, height: (view.frame.height) / 9)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ZikrCountViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
