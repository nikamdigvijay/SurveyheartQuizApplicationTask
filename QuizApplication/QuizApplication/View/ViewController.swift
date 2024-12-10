//
//  ViewController.swift
//  QuizApplication
//
//  Created by Apple on 05/12/24.
//

import UIKit

// MARK: - ViewController

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var Button_Start: UIButton!
    @IBOutlet weak var imageView_quiz: UIImageView!
    
    //MARK: - Internal Properties
    
    
}

//MARK: - Life Cycle Methods
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initialConfigurations()
    }
}

//MARK: - Initial Configurations
extension ViewController {
    func initialConfigurations() {
        self.configure_Image()
        self.configure_Button()
    }
    
    
    func configure_Image() {
        self.imageView_quiz.image = UIImage(named: "quizImg")
        self.imageView_quiz.contentMode = .scaleAspectFit
    }
    
    func configure_Button() {
        self.Button_Start.setTitle(quizScreenString.startButton_text, for: .normal)
        self.Button_Start.backgroundColor = .black
        self.Button_Start.tintColor = .yellow
        self.Button_Start.layer.cornerRadius = 10
    }
}

//MARK: - IBActions
extension ViewController {
    
    @IBAction func button_Start_clicked(_ sender: Any) {
        var quizQuestionVC = self.storyboard?.instantiateViewController(withIdentifier: "QuizQuestionViewController") as! QuizQuestionViewController
        navigationController?.pushViewController(quizQuestionVC, animated: true)
    }
}
