import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var question: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with tickets: Tickets) {
        phoneNumber.text = tickets.answers.answer1
        emailLabel.text = tickets.image
        question.text = tickets.question
    }
}
