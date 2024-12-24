//
//  GroupHatimViewController.swift
//  ZikrTask
//
//  Created by Faxriddin Mo'ydinxonov on 17/09/24.
//

import UIKit
import SnapKit

//Protocols
protocol GroupHatimInfoDelegate: AnyObject {
    func didTapBackButton()
}

protocol FinishedHatmGroupDelete: AnyObject {
    func didTapDeleteButton()
}

class GroupHatimInfoViewController: UIViewController, HatimGroupInfoCollectionViewCellDelegate {
    
    //MARK: - Proporties
    
    //ViewModels
    private let userViewModel               = UserProfileViewModel()
    private let poraViewModel               = PoralarViewModel()
    private let bookPoraViewModel           = BookPoraViewModel()
    private let getBookedPoraViewModel      = GetBookedPoraViewModel()
    private let getUserDetailIdViewModel    = GetUserDetailFromID()
    private let deleteHatmGroupviewModel    = DeleteHatmGroupViewModel()
    private let getHatmUserDetailsViewModel = GetUserDetailViewModel()
    private let patchBookedPoraViewModel    = PatchBookedPoraViewModel()
    
    //UI elements
    private let refreshControl  = UIRefreshControl()
    private let blurEffect      = UIBlurEffect(style: .extraLight)
    private let effect          = UIBlurEffect(style: .light)
    private let darkEffect      = UIBlurEffect(style: .dark)
    private var headerView: HatimInfoHeaderView?
    private var tapGestureRecognizer: UITapGestureRecognizer?
    private var popupMenuView: UIView?
    private var selectedIndexPath: IndexPath?
    private var userProfiles: [IndexPath: (name: String, surname: String)] = [:]
    var groupId: String?
    var bookedPoras: [GetBookedPora] = []
    var cellData: [String: [IndexPath: String]] = [:]
    
    weak var delegate: GroupHatimInfoDelegate?
    weak var deleteProtocol: FinishedHatmGroupDelete?
    
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "backgroundImage")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionview.register(HatimGroupInfoCollectionViewCell.self, forCellWithReuseIdentifier: HatimGroupInfoCollectionViewCell.identifier)
        collectionview.register(HatimInfoHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HatimInfoHeaderView.identifier)
        collectionview.backgroundColor = .clear
        return collectionview
    }()
    
    var activityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.color = .white
        indicator = UIActivityIndicatorView(style: .medium)
        return indicator
    }()
    
    private let loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        view.layer.cornerRadius = 10
        view.alpha = 0
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view and navigation settings
        title = "Guruh Hatmi"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .done, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem?.tintColor = .darkMode
        setupUI()
        callingMethods()
        loadCellDataFromUserDefaults()
        
        //gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutside))
        view.addGestureRecognizer(tapGesture)
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        collectionView.refreshControl = refreshControl
    }
    
    @objc private func refreshData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.refreshControl.endRefreshing()
            self.callingMethods()
        }
    }
    
    private func callingMethods() {
        fetchPoralar()
        getBookedPoraViewModel.fetchBookedPoras(groupId: groupId ?? "")
        getBookedPoraViewModel.didUpdateData = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.loadUserDetails()
                //self?.updateProgress()
            }
        }
        
        
        getHatmUserDetailsViewModel.fetchLoggedInUserDetails()
        getHatmUserDetailsViewModel.didFetchUserDetails = { [weak self] in
            self?.loadBookedPoras()
        }
    }
    
    //MARK: - Set Up UI -
    
    func setupUI() {
        
        //backgroundImage
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //collectionView
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
        
        //activityIndicator
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        loadingView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func showActivityIndicator() {
        activityIndicator.startAnimating()
        
        view.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.1) {
            self.loadingView.alpha = 1
        }
    }
    
    private func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        
        view.isUserInteractionEnabled = true
        
        UIView.animate(withDuration: 0.1) {
            self.loadingView.alpha = 0
        }
    }
    
    //MARK: - Protocol -
    
    func selectionButtonTapped(in cell: HatimGroupInfoCollectionViewCell) {
    }
    
    func finishButtonTapped(in cell: HatimGroupInfoCollectionViewCell) {
        guard let headerView = headerView else {
            print("HeaderView is nil")
            return
        }
        
        let currentProgress = headerView.progressView.progress
        let updatedProgress = currentProgress + 1.0 / 30.0
        headerView.progressView.setProgress(updatedProgress, animated: true)
        
        let currentCount = Int(headerView.progressLabel.text?.components(separatedBy: "/").first ?? "0") ?? 0
        let updatedCount = currentCount + 1
        headerView.progressLabel.text = "\(updatedCount)/30"
    }
    
    //MARK: - Fetch -
    
    func fetchPoralar() {
        poraViewModel.fetchGroups()
        showActivityIndicator()
        
        poraViewModel.onGroupsFetched = { [weak self] in
            DispatchQueue.main.async {
                self?.hideActivityIndicator()
                self?.collectionView.reloadData()
                self?.loadBookedPoras()
            }
        }
    }
    
    func loadBookedPoras() {
        guard let groupId = groupId else { return }
        showActivityIndicator()
        
        getBookedPoraViewModel.fetchBookedPoras(groupId: groupId)
        getBookedPoraViewModel.didUpdateData = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.loadUserDetails()
                self?.updateProgress()
                self?.hideActivityIndicator()
            }
        }
    }
    
    func loadUserDetails() {
        showActivityIndicator()
        
        for bookedPora in getBookedPoraViewModel.bookedPoras {
            getUserDetailIdViewModel.fetchUserDetails(userId: bookedPora.userId)
        }
        
        getUserDetailIdViewModel.didFetchUserDetails = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.hideActivityIndicator()
            }
        }
    }
    
    //MARK: - Actions -
    
    @objc func backButtonTapped() {
        delegate?.didTapBackButton()
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleTapOutside() {
        let visibleIndexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in visibleIndexPaths {
            if let cell = collectionView.cellForItem(at: indexPath) as? HatimGroupInfoCollectionViewCell {
                if cell.isExpanded {
                    cell.resetSelectionView()
                }
            }
        }
    }
    
    @objc func handleStartButtonPress(_ sender: UIButton) {
        handleButtonPress(sender: sender, isBooked: true, isDone: false, buttonState: "Boshlash")
    }
    
    @objc func handleFinishButtonPress(_ sender: UIButton) {
        handleButtonPress(sender: sender, isBooked: false, isDone: true, buttonState: "Tugatish") {
            self.getBookedPoraViewModel.fetchBookedPoras(groupId: self.groupId ?? "")
            self.getBookedPoraViewModel.didUpdateData = { [weak self] in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.updateProgress()
                    self.hideActivityIndicator()
                }
            }
        }
    }
    
    private func handleButtonPress(
        sender: UIButton,
        isBooked: Bool,
        isDone: Bool,
        buttonState: String,
        completion: (() -> Void)? = nil
    ) {
        let index = sender.tag
        let indexPath = IndexPath(item: sender.tag, section: 0)
        let group = poraViewModel.group(at: index)
        let poraId = group.id
        
        // Load cell data from UserDefaults
        loadCellDataFromUserDefaults()
        
        guard let groupID = self.groupId else { return }
        
        if let groupData = cellData[groupID], let existingId = groupData[indexPath] {
            print("Found existing ID \(existingId) for indexPath \(indexPath), proceeding with patch.")
            let requestBody = PatchBookedPoralarRequest(isBooked: isBooked, isDone: isDone, poraId: poraId)
            patchBookedPoraViewModel.patchBookedPoralar(id: existingId, requestBody: requestBody) { result in
                switch result {
                case .success(let response):
                    print(response)
                case .failure(let error):
                    print(error.localizedDescription)
                }
                completion?()
            }
        } else {
            print("No existing booking for indexPath \(indexPath), proceeding with booking.")
            showActivityIndicator()
            
            userViewModel.onUserFetched = { [weak self] user in
                guard let self = self else { return }
                
                self.userProfiles[indexPath] = (name: user.name, surname: user.surname)
                self.updateCell(at: index, withName: user.name, andSurname: user.surname, buttonState: buttonState)
                
                self.bookPoraViewModel.bookPora(idGroup: self.groupId ?? "", poraId: poraId, isBooked: isBooked, isDone: isDone) { result in
                    switch result {
                    case .success(let id):
                        var groupData = self.cellData[groupID] ?? [:]
                        groupData[indexPath] = id
                        self.cellData[groupID] = groupData
                        self.saveCellDataToUserDefaults()
                        print("Successfully booked the pora: \(buttonState) \(id)")
                        completion?()
                    case .failure(let error):
                        print("Error booking pora: \(error.localizedDescription)")
                    }
                    self.hideActivityIndicator()
                }
            }
            
            userViewModel.fetchUserProfile()
        }
    }
    
    func saveCellDataToUserDefaults() {
        let stringKeyedDict = cellData.reduce(into: [String: [String: String]]()) { dict, pair in
            let groupID = pair.key
            let indexPathDict = pair.value.reduce(into: [String: String]()) { subDict, subPair in
                subDict[subPair.key.toString()] = subPair.value
            }
            dict[groupID] = indexPathDict
        }
        UserDefaults.standard.set(stringKeyedDict, forKey: "cellData")
    }
    
    func loadCellDataFromUserDefaults() {
        guard let savedData = UserDefaults.standard.dictionary(forKey: "cellData") as? [String: [String: String]] else { return }
        cellData = savedData.reduce(into: [String: [IndexPath: String]]()) { dict, pair in
            let groupID = pair.key
            let indexPathDict = pair.value.reduce(into: [IndexPath: String]()) { subDict, subPair in
                if let indexPath = IndexPath.fromString(subPair.key) {
                    subDict[indexPath] = subPair.value
                }
            }
            dict[groupID] = indexPathDict
        }
    }
    
    func updateCell(at index: Int, withName name: String, andSurname surname: String, buttonState: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(name, forKey: "userNamee_\(index)")
        userDefaults.set(surname, forKey: "userSurnamee_\(index)")
        userDefaults.set(buttonState, forKey: "buttonState_\(index)")
        userDefaults.synchronize()
        
        let indexPath = IndexPath(row: index, section: 0)
        if let cell = collectionView.cellForItem(at: indexPath) as? HatimGroupInfoCollectionViewCell {
            cell.nameLabel.text = name
            cell.surnameLabel.text = surname
            cell.label.text = buttonState
        } else {
            collectionView.reloadItems(at: [indexPath])
        }
    }
    
    private func updateProgress() {
        guard let headerView = headerView else { return }
        
        let completedCount = getBookedPoraViewModel.bookedPoras.filter { $0.isDone }.count
        UserDefaults.standard.isDoneCount = completedCount
        
        let maxProgressValue = 30
        headerView.progressView.setProgress(Float(completedCount) / Float(maxProgressValue), animated: true)
        headerView.progressLabel.text = "\(completedCount)/\(maxProgressValue)"
        
        if completedCount == maxProgressValue {
            if !UserDefaults.standard.bool(forKey: "finishedPoraTriggered") {
                UserDefaults.standard.set(true, forKey: "finishedPoraTriggered")
                showSuccessAlert()
            }
            showSuccessAlert()
        }
    }
    
    func postFinishedPoraCount(idGroup: String) {
        let finishedPoraViewModel = FinishedPoraViewModel()
        
        finishedPoraViewModel.onSuccess = { response in
            print("Finished pora processed successfully. Current juzCount:", response.juzCount)
            
            self.getBookedPoraViewModel.deleteAllBookedPoras { success in
                if success {
                    print("All booked poras deleted successfully.")
                    
                    self.clearAllData()
                } else {
                    print("Failed to delete all booked poras.")
                }
            }
        }
        
        finishedPoraViewModel.onFailure = { error in
            print("Failed to process finished pora:", error.localizedDescription)
        }
        
        finishedPoraViewModel.onTargetLayersCompleted = { [weak self] in
            DispatchQueue.main.async {
                self?.showCompletionAlert()
            }
        }
        
        finishedPoraViewModel.sendFinishedPoraRequest(idGroup: idGroup)
    }
    
    private func clearAllData() {
        self.getBookedPoraViewModel.bookedPoras.removeAll()
        UserDefaults.standard.isDoneCount = 0
        UserDefaults.standard.set(false, forKey: "finishedPoraTriggered")
        
        self.cellData.removeAll()
        UserDefaults.standard.removeObject(forKey: "cellData")
        self.updateProgress()
        self.collectionView.reloadData()
    }
    
    
    private func showSuccessAlert() {
        let alert = UIAlertController(
            title: "Muvaffaqiyatli",
            message: "Xatmi Qur'on qildingiz",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.postFinishedPoraCount(idGroup: self.groupId ?? " ")
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    func showCompletionAlert() {
        let alert = UIAlertController(title: "Muvaffaqiyatli", message: "Siz barcha xatmlarni tugatdingiz!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            self?.finishAllPora()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func finishAllPora() {
        self.deleteHatmGroupviewModel.deleteGroup(with: groupId ?? "") { result in
            DispatchQueue.main.async {
                self.showActivityIndicator()
                switch result {
                case .success:
                    print("Success")
                case .failure(let error):
                    print("Failure")
                    self.navigationController?.popViewController(animated: true)
                    self.deleteProtocol?.didTapDeleteButton()
                    self.hideActivityIndicator()
                }
            }
        }
    }
    
}

//UICollectionViewDataSource
extension GroupHatimInfoViewController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return poraViewModel.groups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HatimGroupInfoCollectionViewCell.identifier, for: indexPath) as! HatimGroupInfoCollectionViewCell
        
        cell.delegate = self
        
        let group = poraViewModel.group(at: indexPath.row)
        let poraID = group.id
        
        cell.hatimCountLabel.text = group.name
        cell.groupId = groupId
        
        cell.startButton.tag = indexPath.row
        cell.finishButton.tag = indexPath.row
        
        cell.startButton.addTarget(self, action: #selector(handleStartButtonPress(_:)), for: .touchUpInside)
        cell.finishButton.addTarget(self, action: #selector(handleFinishButtonPress(_:)), for: .touchUpInside)
        
        if let booking = getBookedPoraViewModel.bookedPoras.first(where: { $0.poraId == poraID }) {
            if let userDetails = getUserDetailIdViewModel.userDetails[booking.userId] {
                cell.nameLabel.text = userDetails.name
                cell.surnameLabel.text = userDetails.surname
                cell.label.text = booking.isBooked ? "Boshlash" : "Tugatish"
                
                let loggedInUserId = getHatmUserDetailsViewModel.loggedInUserId
                
                if userDetails.userId == loggedInUserId {
                    cell.enableSelectionView(access: true)
                } else {
                    cell.enableSelectionView(access: false)
                }
                
            } else {
                getUserDetailIdViewModel.fetchUserDetails(userId: booking.userId)
            }
        } else {
            cell.nameLabel.text = "Name"
            cell.surnameLabel.text = "Surname"
            cell.label.text = "Tanlash"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSizeMake(view.bounds.width , view.bounds.height / 7) //7
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleIndexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in visibleIndexPaths {
            if let cell = collectionView.cellForItem(at: indexPath) as? HatimGroupInfoCollectionViewCell {
                if cell.isExpanded {
                    cell.resetSelectionView()
                }
            }
        }
    }
    //HeaderView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HatimInfoHeaderView.identifier, for: indexPath) as! HatimInfoHeaderView
        self.headerView = headerView
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.bounds.width, height: 60)
    }
}

extension UserDefaults {
    private enum Keys {
        static let isDoneCount = "isDoneCount"
        
        static let finishedPoraId = "finishedPoraId"
        static let currentJuzCount = "currentJuzCount"
    }
    
    var isDoneCount: Int {
        get { integer(forKey: Keys.isDoneCount) }
        set { set(newValue, forKey: Keys.isDoneCount) }
    }
    
    var finishedPoraId: String? {
        get { string(forKey: Keys.finishedPoraId) }
        set { set(newValue, forKey: Keys.finishedPoraId) }
    }
    
    var currentJuzCount: Int {
        get { integer(forKey: Keys.currentJuzCount) }
        set { set(newValue, forKey: Keys.currentJuzCount) }
    }
}

extension IndexPath {
    func toString() -> String {
        return "\(section)-\(item)"
    }
    
    static func fromString(_ string: String) -> IndexPath? {
        let components = string.split(separator: "-").compactMap { Int($0) }
        guard components.count == 2 else { return nil }
        return IndexPath(item: components[1], section: components[0])
    }
}
