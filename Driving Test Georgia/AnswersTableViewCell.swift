import UIKit

class AnswersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var viewAnswerBg: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewAnswerBg.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setup(answer: String) {
        answerLabel.text = answer
    }
}
