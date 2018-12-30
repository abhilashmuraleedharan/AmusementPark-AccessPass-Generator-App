//
//  ViewController.swift
//  AmusementParkAccessPassGeneratorApp
//
//  Created by Abhilash Muraleedharan on 28/10/18.
//  Copyright © 2018 AbhilashApps. All rights reserved.
//

import UIKit

class AccessPassFormVC: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var subMenuView: UIStackView!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var dateOfVisitLabel: UILabel!
    @IBOutlet weak var dateOfVisitTextField: UITextField!
    @IBOutlet weak var projectNumberLabel: UILabel!
    @IBOutlet weak var projectNumberTextField: UITextField!
    @IBOutlet weak var managerTypeLabel: UILabel!
    @IBOutlet weak var managerTypeTextField: UITextField!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var streetAddressLabel: UILabel!
    @IBOutlet weak var streetAddressTextField: UITextField!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipcodeLabel: UILabel!
    @IBOutlet weak var zipcodeTextField: UITextField!
    @IBOutlet weak var generatePassButton: UIButton!
    @IBOutlet weak var populateDataButton: UIButton!
    
    // MARK: - Stored Properties
    let subMenuButtonBackgroundColor = UIColor(red: 48/255, green: 41/255, blue: 55/255, alpha: 1.0)
    let disabledLabelTextColor = UIColor.lightGray
    let enabledLabelTextColor = UIColor.black
    let dataProvider = FormDataProvider()
    lazy var subMenuBlankView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = subMenuButtonBackgroundColor
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let projectPicker = UIPickerView()
        projectPicker.tag = ViewPickerTag.projectTag.rawValue
        projectPicker.delegate = self
        let companyPicker = UIPickerView()
        companyPicker.tag = ViewPickerTag.companyTag.rawValue
        companyPicker.delegate = self
        let managerTypePicker = UIPickerView()
        managerTypePicker.tag = ViewPickerTag.typeTag.rawValue
        managerTypePicker.delegate = self
        projectNumberTextField.inputView = projectPicker
        companyTextField.inputView = companyPicker
        managerTypeTextField.inputView = managerTypePicker
    }
    
    // MARK: - IB Actions
    @IBAction func guestMenuOptionSelected(_ sender: Any) {
        deactivateForm()
        displaySubMenu(for: .guest)
    }
    
    @IBAction func employeeMenuOptionSelected(_ sender: Any) {
        deactivateForm()
        displaySubMenu(for: .employee)
    }
    
    @IBAction func managerMenuOptionSelected(_ sender: Any) {
        subMenuView.removeAllArrangedSubviews()
        subMenuView.addArrangedSubview(subMenuBlankView)
        deactivateForm()
        activateForm(for: .manager)
    }
    
    @IBAction func contractorMenuOptionSelected(_ sender: Any) {
        subMenuView.removeAllArrangedSubviews()
        subMenuView.addArrangedSubview(subMenuBlankView)
        deactivateForm()
        activateForm(for: .contractor)
    }
    
    @IBAction func vendorMenuOptionSelected(_ sender: Any) {
        subMenuView.removeAllArrangedSubviews()
        subMenuView.addArrangedSubview(subMenuBlankView)
        deactivateForm()
        activateForm(for: .vendor)
    }
    
    @IBAction func generatePassButtonTapped(_ sender: Any) {
    }
    
    @IBAction func populateDataButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Methods
    func displaySubMenu(for passType: PassCategory) {
        let associatedPassSubTypes = passType.passSubTypeList
        updateSubMenuStackView(with: associatedPassSubTypes)
    }
    
    func updateSubMenuStackView(with passSubTypeList: [PassSubType]) {
        let menuButtonSubViews = prepareSubMenuButtons(using: passSubTypeList)
        subMenuView.removeAllArrangedSubviews()
        for buttonView in menuButtonSubViews {
            subMenuView.addArrangedSubview(buttonView)
        }
    }
    
    func prepareSubMenuButtons(using passSubTypesList: [PassSubType]) -> [UIButton] {
        var subMenuButtonViews = [UIButton]()
        for pass in passSubTypesList {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            let title = pass.subMenuButtonTitle ?? ""
            button.setTitle(title, for: .normal)
            button.backgroundColor = subMenuButtonBackgroundColor
            button.tintColor = UIColor.white
            if let selector = getButtonActionSelector(for: pass) {
                button.addTarget(self, action: selector, for: .touchUpInside)
            }
            subMenuButtonViews.append(button)
        }
        return subMenuButtonViews
    }
    
    // MARK: - Helper Methods
    func getButtonActionSelector(for passType: PassSubType) -> Selector? {
        var selector: Selector?
        switch passType {
        case .classicGuestPass, .vipGuestPass, .freeChildGuestPass, .seniorGuestPass, .seasonGuestPass:
            selector = #selector(AccessPassFormVC.setUpGuestForm)
        case .hourlyEmployeeMaintenancePass, .hourlyEmployeeFoodServicePass, .hourlyEmployeeRideServicePass:
            selector = #selector(AccessPassFormVC.setUpEmployeeForm)
        default: selector = nil
        }
        return selector
    }
    
    @objc func setUpGuestForm() {
        activateForm(for: .guest)
    }
    
    @objc func setUpEmployeeForm() {
        activateForm(for: .employee)
    }
    
    @objc func setUpManagerForm() {
        activateForm(for: .manager)
    }
    
    @objc func setUpContractorForm() {
        activateForm(for: .contractor)
    }
    
    @objc func setUpVendorForm() {
        activateForm(for: .vendor)
    }
    
    func activateForm(for passType: PassCategory) {
        deactivateForm()
        switch passType {
        case .vendor:
            dateOfVisitLabel.textColor = enabledLabelTextColor
            companyLabel.textColor = enabledLabelTextColor
            dateOfVisitTextField.isEnabled = true
            companyTextField.isEnabled = true
        case .contractor:
            projectNumberLabel.textColor = enabledLabelTextColor
            projectNumberTextField.isEnabled = true
        case .manager:
            managerTypeLabel.textColor = enabledLabelTextColor
            managerTypeTextField.isEnabled = true
        default: break
        }
        activateGeneralFormFields()
        activateButtons()
    }
    
    func deactivateForm() {
        disableLabels()
        disableTextFields()
        disableButtons()
    }
    
    func activateGeneralFormFields() {
        firstNameLabel.textColor = enabledLabelTextColor
        lastNameLabel.textColor = enabledLabelTextColor
        streetAddressLabel.textColor = enabledLabelTextColor
        cityLabel.textColor = enabledLabelTextColor
        stateLabel.textColor = enabledLabelTextColor
        zipcodeLabel.textColor = enabledLabelTextColor
        dateOfBirthLabel.textColor = enabledLabelTextColor
        dateOfBirthTextField.isEnabled = true
        firstNameTextField.isEnabled = true
        lastNameTextField.isEnabled = true
        streetAddressTextField.isEnabled = true
        cityTextField.isEnabled = true
        stateTextField.isEnabled = true
        zipcodeTextField.isEnabled = true
    }
    
    func disableLabels() {
        firstNameLabel.textColor = disabledLabelTextColor
        lastNameLabel.textColor = disabledLabelTextColor
        streetAddressLabel.textColor = disabledLabelTextColor
        cityLabel.textColor = disabledLabelTextColor
        stateLabel.textColor = disabledLabelTextColor
        zipcodeLabel.textColor = disabledLabelTextColor
        dateOfBirthLabel.textColor = disabledLabelTextColor
        dateOfVisitLabel.textColor = disabledLabelTextColor
        companyLabel.textColor = disabledLabelTextColor
        projectNumberLabel.textColor = disabledLabelTextColor
        managerTypeLabel.textColor = disabledLabelTextColor
    }
    
    func disableTextFields() {
        dateOfBirthTextField.isEnabled = false
        dateOfVisitTextField.isEnabled = false
        projectNumberTextField.isEnabled = false
        managerTypeTextField.isEnabled = false
        firstNameTextField.isEnabled = false
        lastNameTextField.isEnabled = false
        companyTextField.isEnabled = false
        streetAddressTextField.isEnabled = false
        cityTextField.isEnabled = false
        stateTextField.isEnabled = false
        zipcodeTextField.isEnabled = false
    }
    
    func disableButtons() {
        generatePassButton.isEnabled = false
        populateDataButton.isEnabled = false
    }
    
    func activateButtons() {
        generatePassButton.isEnabled = true
        populateDataButton.isEnabled = true
    }

}

extension AccessPassFormVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch ViewPickerTag(rawValue: pickerView.tag)! {
        case ViewPickerTag.companyTag: return dataProvider.companyPickerData.count
        case ViewPickerTag.projectTag: return dataProvider.projectPickerData.count
        case ViewPickerTag.typeTag: return dataProvider.typePickerData.count
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch ViewPickerTag(rawValue: pickerView.tag)! {
        case ViewPickerTag.companyTag: return dataProvider.companyPickerData[row]
        case ViewPickerTag.projectTag: return dataProvider.projectPickerData[row]
        case ViewPickerTag.typeTag: return dataProvider.typePickerData[row]
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch ViewPickerTag(rawValue: pickerView.tag)! {
        case ViewPickerTag.companyTag: companyTextField.text = dataProvider.companyPickerData[row]
        case ViewPickerTag.projectTag: projectNumberTextField.text = dataProvider.projectPickerData[row]
        case ViewPickerTag.typeTag: managerTypeTextField.text = dataProvider.typePickerData[row]
        }
    }
}

