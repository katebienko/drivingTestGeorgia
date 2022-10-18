import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewCategoryBB1: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDesignViews()
    }
    
    private func setDesignViews() {
        viewCategoryBB1.layer.cornerRadius = 30
        viewCategoryBB1.backgroundColor = UIColor(red: 237/255.0, green: 237/255.0, blue: 237/255.0, alpha: 1.0)
    }
}

