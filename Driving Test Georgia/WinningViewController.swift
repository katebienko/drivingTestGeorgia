import UIKit

class WinningViewController: UIViewController {

    @IBOutlet private var bgView: UIView!
    @IBOutlet private weak var scoreView: UIView!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var imageSuccess: UIImageView!
    @IBOutlet private weak var startFromBeginning: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgSettings()
        navigationBarSettings()
        imageSettings()
        getResult()
        scoreViewSettings()
        buttonDesign()
    }
    
    private func buttonDesign() {
        startFromBeginning.backgroundColor = UIColor(red: 251.0/255.0, green: 224.0/255.0, blue: 94.0/255.0, alpha: 1.0)
        startFromBeginning.layer.cornerRadius = startFromBeginning.frame.height / 2
    }
    
    private func getResult() {
        let result = UserDefaults.standard.integer(forKey: "count")
        scoreLabel.text = "\(result)/30"
    }
    
    private func scoreViewSettings() {
        scoreView.layer.cornerRadius = 20
    }
    
    private func imageSettings() {
        imageSuccess.image = UIImage(named: "success.png")
    }
    
    private func navigationBarSettings() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func bgSettings() {
      //  bgView.backgroundColor = UIColor(red: 13.0/255.0, green: 29.0/255.0, blue: 54.0/255.0, alpha: 1.0)
        bgView.backgroundColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 247.0/255.0, alpha: 1.0)
    }
}
