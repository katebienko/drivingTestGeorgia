import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    var answersArray: [String] = []

    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer1: UILabel!
    @IBOutlet weak var answer2: UILabel!    
    @IBOutlet weak var answer3: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with tickets: Tickets) {
        
        for i in 0 ... tickets.answers.count - 1 {
            answersArray.append(tickets.answers[i].text)
        }
        
        answersArray.shuffle()
        
        question.text = tickets.question
        answer1.text = answersArray[0]
        answer2.text = answersArray[1]
        answer3.text = answersArray[2]
    }
}
