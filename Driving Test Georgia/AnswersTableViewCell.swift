import UIKit

class AnswersTableViewCell: UITableViewCell {

    @IBOutlet weak var answerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func setup(answer: String) {
        answerLabel.text = answer
    }
}
