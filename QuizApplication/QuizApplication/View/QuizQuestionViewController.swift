//
//  QuizQuestionViewController.swift
//  QuizApplication
//
//  Created by Apple on 06/12/24.
//

import UIKit

//MARK: - QuizQuestionViewController
class QuizQuestionViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var label_question: UILabel!
    @IBOutlet weak var label_timer: UILabel!
    
    @IBOutlet weak var Button_optionsOne: UIButton!
    @IBOutlet weak var Button_optionsTwo: UIButton!
    @IBOutlet weak var Button_optionsThree: UIButton!
    @IBOutlet weak var Button_optionsFour: UIButton!
    
    
    //MARK: - Internal Properties
    var questions: [QuizQuestion] = []
    var currentQuestionIndex = 0
    var score = 0
    var timer: Timer?
    var timeRemaining = 60 // 10 seconds per question
    
    
}
//MARK: - Life Cycle Methods
extension QuizQuestionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initialConfigurations()
    }
}

//MARK: - Initial Configurations
extension QuizQuestionViewController {
    func initialConfigurations() {
        self.configure_hideBackButton()
        self.configure_View()
        self.configure_label()
        self.configure_Button()
        self.setupQuestions()
        self.loadQuestion()
    }
    
    //MARK: - Hide the Back Button
    func configure_hideBackButton() {
        self.navigationItem.hidesBackButton = true
    }
    
    func configure_View() {
        self.view.backgroundColor = .black
    }
    
    func configure_label() {
        self.label_question.text = quizScreenString.quizQueOne_text
        self.label_question.textColor = .yellow
        self.label_question.numberOfLines = 0
        self.label_question.font = UIFont.boldSystemFont(ofSize: 24)
        self.label_question.textAlignment = .center
        
        self.label_timer.text = "01:00"
        self.label_timer.textColor = .yellow
        self.label_timer.numberOfLines = 0
        self.label_timer.textAlignment = .right
        self.label_timer.font = UIFont.boldSystemFont(ofSize: 20)
        
    }
    
    func configure_Button() {
        let buttons = [Button_optionsOne, Button_optionsTwo, Button_optionsThree, Button_optionsFour]
        buttons.forEach { button in
            button?.backgroundColor = .white
            button?.tintColor = .black
            button?.layer.cornerRadius = 10
            button?.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
        }
    }
    
    // MARK: - Timer Management
    func startTimer() {
        timeRemaining = 60
        label_timer.text = "Time: \(timeRemaining)s"
        timer?.invalidate() // Ensure only one timer is running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.timeRemaining -= 1
            self.label_timer.text = "Time: \(self.timeRemaining)s"
            
            if self.timeRemaining == 0 {
                self.timer?.invalidate()
                self.showTimeUpAlert()
            }
        }
    }
    
    
    // MARK: - Quiz Logic
    func setupQuestions() {
        questions = [
            QuizQuestion(text: quizScreenString.quizQueOne_text, options: ["Defining UI elements", " Handling app lifecycle events", "Implementing networking logic", "Parsing JSON data"], correctAnswer: 1),
            
            QuizQuestion(text: quizScreenString.quizQueTwo_text, options: ["Making network requests", "Handling user authentication", "Managing data persistence", " Displaying maps"], correctAnswer: 2),
            
            QuizQuestion(text: quizScreenString.quizQueThree_text, options: ["Database management", "User interface elements", "Networking capabilities", "File system access"], correctAnswer: 1),
            
            QuizQuestion(text: quizScreenString.quizQueFour_text, options: ["CocoaPods", "Swift Package Manager", "Xcode Dependency Manager", "Carthage"], correctAnswer: 0),
            
            QuizQuestion(text: quizScreenString.quizQueFive_text, options: ["protocol MyProtocol {}", "interface MyProtocol {}", "@interface MyProtocol {}", "@protocol MyProtocol {}"], correctAnswer: 0),
            
            QuizQuestion(text: quizScreenString.quizQueSix_text, options: ["To prevent strong reference cycles", "To create a constant.", "To perform mathematical operations.", "To handle user input."], correctAnswer: 0),
            
            QuizQuestion(text: quizScreenString.quizQueSeven_text, options: ["Using if let", "Using guard let", "Using force unwrap (!)", "Using switch case"], correctAnswer: 3),
            
            QuizQuestion(text: quizScreenString.quizQueEight_text, options: ["enum", "enumeration", "enum class", "enumerator"], correctAnswer: 0),
            
            QuizQuestion(text: quizScreenString.quizQueNine_text, options: [" UIKit", "CoreData", "CoreLocation", "AVFoundation"], correctAnswer: 0),
            
            QuizQuestion(text: quizScreenString.quizQueTen_text, options: ["UserDefaults", "SQLite", "Core Data", "HTTP Cookies"], correctAnswer: 3)
        ]
    }
    
    func loadQuestion() {
        guard currentQuestionIndex < questions.count else {
            stopTimer()
            showCompletionAlert()
            return
        }
        
        let currentQuestion = questions[currentQuestionIndex]
        label_question.text = currentQuestion.text
        
        let buttons = [Button_optionsOne, Button_optionsTwo, Button_optionsThree, Button_optionsFour]
        for (index, button) in buttons.enumerated() {
            button?.setTitle(currentQuestion.options[index], for: .normal)
            button?.tag = index // Set tag to match the option index
        }
        startTimer()
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
    // MARK: - Alerts
    func showTimeUpAlert() {
        let alert = UIAlertController(title: "Time's Up!", message: "You ran out of time for this question.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Next", style: .default, handler: { _ in
            self.currentQuestionIndex += 1
            self.loadQuestion()
        }))
        present(alert, animated: true)
    }
    
    func showCompletionAlert() {
        // Navigate to ResultViewController
        guard let resultVC = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController else {
            return
        }
        resultVC.finalScore = score
        resultVC.totalQuestions = questions.count
        navigationController?.pushViewController(resultVC, animated: true)
    }
    
    
    
    // MARK: - Option Selection
    @objc func optionSelected(_ sender: UIButton) {
        stopTimer()
        let selectedAnswer = sender.tag
        let correctAnswer = questions[currentQuestionIndex].correctAnswer
        
        if selectedAnswer == correctAnswer {
            score += 1 // Increase score for correct answer
        }
        
        currentQuestionIndex += 1
        loadQuestion()
    }
}
