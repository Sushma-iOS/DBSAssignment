import UIKit

class ViewController: UIViewController, ParsingHandler {
    
    @IBOutlet weak var contactsTable: UITableView!
    var viewModelArray = [ContactsViewModel]()
    var viewModel: ContactsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.fetchInitialData()
        self.contactsTable.reloadData()
    }

     // MARK: - Fetch data
    func fetchInitialData(){
        viewModelArray = self.fetchDataFromDB()
        
        //sorting in alphabetical order
        viewModelArray = viewModelArray.sorted(by: { (item1, item2) -> Bool in
            return item1.name!.compare(item2.name!) == ComparisonResult.orderedAscending
        })
    }
    func fetchDataFromDB() -> [ContactsViewModel] {
        var modelArray: [Contact] = CoredataManager.shared.fetch(Contact.self)!
        if(modelArray.count == 0){
            modelArray = self.readJson()!
        }
        return initViewModels(modelArray)!
        
    }
    
    //MARK: - Segue Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == Constants.SegueNames.detailViewController {
                let vc = segue.destination as? DetailViewController
                let index = self.contactsTable.indexPathForSelectedRow?.row
                vc?.reloadModelViews = {
                    self.fetchInitialData()
                    self.contactsTable.reloadData()
                }
                vc?.detailViewModel = viewModelArray[index!]
            }
        }
}
    
    //MARK: - TableView Methods
    extension ViewController: UITableViewDataSource, UITableViewDelegate {
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModelArray.count
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 70
        }
        func sectionIndexTitles(for tableView: UITableView) -> [String]? {
            
            let str = Constants.Alphabets.alphabetsStr
            let characterArray = str.components(separatedBy: " ")
            return characterArray
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let contactCell: ContactsCell = (tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCellNames.contactCell) as? ContactsCell)!
            contactCell.contactViewModel = viewModelArray[indexPath.row]
            return contactCell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            viewModel = viewModelArray[indexPath.row]
        }

}



