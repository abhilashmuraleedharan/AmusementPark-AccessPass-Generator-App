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
    
    lazy var projectPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.tag = AccessPassFormPickerView.project.tag
        picker.delegate = self
        return picker
    }()
    
    lazy var companyPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.tag = AccessPassFormPickerView.company.tag
        picker.delegate = self
        return picker
    }()
    
    lazy var managerTypePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.tag = AccessPassFormPickerView.managerType.tag
        picker.delegate = self
        return picker
    }()
    
    lazy var dateOfBirthPicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    lazy var dateOfVisitPicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRelevantTextFieldsWithUIPickerViews()
        configureRelevantTextFieldsWithDatePickerViews()
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
    
    func configureRelevantTextFieldsWithUIPickerViews() {
        projectNumberTextField.inputView = projectPicker
        companyTextField.inputView = companyPicker
        managerTypeTextField.inputView = managerTypePicker
    }
    
    func configureRelevantTextFieldsWithDatePickerViews() {
        dateOfBirthTextField.inputView = dateOfBirthPicker
        dateOfBirthTextField.inputAccessoryView = getToolBar(for: .dateOfBirth)
        dateOfVisitTextField.inputView = dateOfVisitPicker
        dateOfVisitTextField.inputAccessoryView = getToolBar(for: .dateOfVisit)
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
    
    @objc func doneSelectingDateOfBirth() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateOfBirthTextField.text = dateFormatter.string(from: dateOfBirthPicker.date)
        view.endEditing(true)
    }
    
    @objc func doneSelectingDateOfVisit() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateOfVisitTextField.text = dateFormatter.string(from: dateOfVisitPicker.date)
        view.endEditing(true)
    }
    
    @objc func dismissDatePicker() {
        view.endEditing(true)
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
    
    func getToolBar(for datePicker: AccessPassFormDatePicker) -> UIToolbar {
        let toolBar = UIToolbar();
        toolBar.sizeToFit()
        let doneButton: UIBarButtonItem
        switch datePicker {
        case .dateOfBirth:
            doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(AccessPassFormVC.doneSelectingDateOfBirth))
        case .dateOfVisit:
            doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(AccessPassFormVC.doneSelectingDateOfVisit))
        }
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(AccessPassFormVC.dismissDatePicker))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        return toolBar
    }
    
    func deactivateForm() {
        disableLabels()
        disableTextFields()
        emptyOutFormTextFields()
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
    
    func emptyOutFormTextFields() {
        dateOfBirthTextField.text = ""
        dateOfVisitTextField.text = ""
        projectNumberTextField.text = ""
        managerTypeTextField.text = ""
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        streetAddressTextField.text = ""
        cityTextField.text = ""
        stateTextField.text = ""
        zipcodeTextField.text = ""
        companyTextField.text = ""
    }

}

extension AccessPassFormVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch AccessPassFormPickerView(rawValue: pickerView.tag)! {
        case AccessPassFormPickerView.company: return dataProvider.companyPickerViewData.count
        case AccessPassFormPickerView.project: return dataProvider.projectPickerViewData.count
        case AccessPassFormPickerView.managerType: return dataProvider.managerTypePickerViewData.count
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch AccessPassFormPickerView(rawValue: pickerView.tag)! {
        case AccessPassFormPickerView.company: return dataProvider.companyPickerViewData[row]
        case AccessPassFormPickerView.project: return dataProvider.projectPickerViewData[row]
        case AccessPassFormPickerView.managerType: return dataProvider.managerTypePickerViewData[row]
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch AccessPassFormPickerView(rawValue: pickerView.tag)! {
        case AccessPassFormPickerView.company: companyTextField.text = dataProvider.companyPickerViewData[row]
        case AccessPassFormPickerView.project: projectNumberTextField.text = dataProvider.projectPickerViewData[row]
        case AccessPassFormPickerView.managerType: managerTypeTextField.text = dataProvider.managerTypePickerViewData[row]
        }
        view.endEditing(true)
    }
}

