import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer1: UILabel!
    @IBOutlet weak var answer2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with tickets: Tickets) {
        question.text = tickets.question
        answer1.text = tickets.answers[0].text
        answer2.text = tickets.answers[1].text
    }
}
