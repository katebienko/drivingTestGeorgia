import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewCategoryBB1: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDesignViews()
        tapViewCategoryBB1()
    }
    
    private func tapViewCategoryBB1() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewCategoryBB1.isUserInteractionEnabled = true
        viewCategoryBB1.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
       
        if let testViewController = storyboard.instantiateViewController(identifier: "TestViewController") as? TestViewController {
            testViewController.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(testViewController, animated: true)
        }
    }
    
    private func setDesignViews() {
        viewCategoryBB1.layer.cornerRadius = 30
        viewCategoryBB1.backgroundColor = UIColor(red: 237/255.0, green: 237/255.0, blue: 237/255.0, alpha: 1.0)
    }
}

