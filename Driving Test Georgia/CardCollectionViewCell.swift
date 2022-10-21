import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var question: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with tickets: Tickets) {
        phoneNumber.text = tickets.phone
        emailLabel.text = tickets.email
        question.text = tickets.name
    }
}
