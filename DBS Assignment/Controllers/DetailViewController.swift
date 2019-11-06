import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var imgViewProfile: UIImageView!{
        didSet{
            imgViewProfile.setCornerRadius(radius: 50.0, borderWidth: 2.0)
        }
    }
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgViewFavorite: UIImageView!
    var detailViewModel: ContactsViewModel?
    var reloadModelViews: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.updateHeaderUI()
        self.detailTableView.reloadData()
    }
    
    // MARK: - Update Header UI
    func updateHeaderUI(){
        self.imgViewProfile.image = UIImage.init(named: (detailViewModel?.image)!)
        self.lblName.text = detailViewModel?.name
        if(detailViewModel?.favourite == true){
            imgViewFavorite.image = UIImage.init(named: Constants.ImageNames.favouriteselected)
        }else{
            imgViewFavorite.image = UIImage.init(named: Constants.ImageNames.favouriteNormal)
        }
    }
    
    // MARK: - IBActions

    @IBAction func favouriteButtonTapped(_ sender: Any) {
        if(imgViewFavorite.image == UIImage.init(named: Constants.ImageNames.favouriteNormal)){
            imgViewFavorite.image = UIImage.init(named: Constants.ImageNames.favouriteselected)
            CoredataManager.shared.updateContactFavourite(Contact.self, idStr: (self.detailViewModel?.id)!, value: true)
        }else{
            imgViewFavorite.image = UIImage.init(named: Constants.ImageNames.favouriteNormal)
            CoredataManager.shared.updateContactFavourite(Contact.self, idStr: (self.detailViewModel?.id)!, value: false)
        }
        if let callBack = reloadModelViews{
            callBack()
        }
    }
    @IBAction func deleteButtonTapped(_ sender: Any) {
        CoredataManager.shared.deleteContact(Contact.self, idStr: (self.detailViewModel?.id)!)
        if let callBack = reloadModelViews{
            callBack()
        }
        self.navigationController?.popViewController(animated: true)
    }
    

}
//MARK: - TableView Methods

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contactCell: ContactDetailCell = (tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCellNames.contactDetailCell) as? ContactDetailCell)!
        if(indexPath.row == 0){
            contactCell.lblTitle.text = Constants.TitleNames.mobileKey
            contactCell.lblValue.text = self.detailViewModel?.phoneNumber
        }else{
            contactCell.lblTitle.text = Constants.TitleNames.emailKey
            contactCell.lblValue.text = self.detailViewModel?.email
        }
        return contactCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    
    
    
}
