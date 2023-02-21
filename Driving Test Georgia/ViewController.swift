import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var titleTExt: UILabel!
    @IBOutlet private weak var testButton: UIButton!
    @IBOutlet private weak var imageLines: UIImageView!
    @IBOutlet private var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backButtonTitle = "Назад"
        
        titleTExt.textColor = .black
        bgView.backgroundColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 247.0/255.0, alpha: 1.0)
        
        testButton.layer.cornerRadius = testButton.frame.height / 2
        testButton.backgroundColor = UIColor(red: 251.0/255.0, green: 224.0/255.0, blue: 94.0/255.0, alpha: 1.0)
        
        imageLines.image = UIImage(named: "abstract.svg")
    }
    
    @IBAction func testButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
       
        if let testViewController = storyboard.instantiateViewController(identifier: "TestViewController") as? TestViewController {
            testViewController.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(testViewController, animated: true)
        }
    }
}

