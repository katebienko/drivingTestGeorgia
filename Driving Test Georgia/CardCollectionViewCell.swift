import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer1: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with tickets: Tickets) {
        question.text = tickets.question
        answer1.text = tickets.answers.answer1
        emailLabel.text = tickets.image
    }
}
