

import UIKit

class ContactsCell: UITableViewCell {
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgViewFav: UIImageView!
    
    var contactViewModel: ContactsViewModel? {
        didSet {
            lblName?.text = contactViewModel?.name
            imgProfile?.image = UIImage.init(named: (contactViewModel?.image)!)
            imgProfile?.contentMode = .scaleAspectFill
            imgProfile.setCornerRadius(radius: 20.0, borderWidth: 0.0)
            if(contactViewModel?.favourite == true){
                imgViewFav.isHidden = false
            }else{
                imgViewFav.isHidden = true
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
