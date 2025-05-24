// to run the file from command line/terminal paste and run : "swift ~/Desktop/Assignment_2_IOS.playground/Contents.swift"

import Foundation

// Enum representing possible courses a student can enroll in
enum Course : Codable
{
    case A , B , C , D , E , F
}

//Enum representing possible fields by which array can be sorted
enum SortField: String {
    case name, age, address, rollNumber
}

//Enum representing possible order by which array can be sorted
enum SortOrder {
    case ascending, descending
}

//Struct representing student with all attributes of a sudent
struct Student : Codable
{
    var studentName : String
    var studentAge : Int
    var studentAddress : String
    var studentRollNumber : Int
    var courses : [Course]?
    
}

// Enum to represent possible errors while taking value inputs
enum InputError: Error{
    case EmptySudentName
    case InvalidStudentAge
    case EmptyStudentAge
    case EmptyAddress
    case InvalidRollNumber
    case EmptyRollNumner
    case DuplicateRollNumber
    case InvalidCourse
}


// Class with all the functionalities to add , delete and save user
class StudenDetailManager{
   
    // Array to store all students
    var students : [Student] = []
    
    //Set to prevent duplicate roll numbers
    var studentRollNo : Set<String> = []
   
    //Initializing inputs to class
    init(students: [Student] , studentRollNo: Set<String>) {
        self.studentRollNo = studentRollNo
        self.students = students
    }
    
    // Method to add student details
    func addUserDetails(){
        
        // Method to validate name
        func getValidName(_ Input : String?)throws -> String{
            guard let name = Input , name != ""
            else {
                throw InputError.EmptySudentName
            }
            return name
        }
        
        // Method to validate age
        func getValidAge(_ Input : String?)throws -> Int{
            guard let age = Int(Input ?? "") , age > 0 else{
                if Input == ""
                {
                    throw InputError.EmptyStudentAge
                }
                else{
                    throw InputError.InvalidStudentAge
                }
            }
            return age
        }
        
        
        // Method to validate address
        func getValidAddress(_ Input : String?)throws ->String{
            guard let address = Input, address != ""  else{
                throw InputError.EmptyAddress
            }
            return address
        }
        
        
        // Method to validate roll number
        func getValidRollNumber(_ Input : String?)throws ->Int{
            guard let input = Input, let rollNo = Int(input), rollNo > 0 else {
                   if Input == "" {
                       throw InputError.EmptyRollNumner
                   } else {
                       throw InputError.InvalidRollNumber
                   }
               }

               if studentRollNo.contains(String(rollNo)) {
                   throw InputError.DuplicateRollNumber
               }
            return rollNo
        }
        
        
        // method to validate course
        func getValidCourse (_ Input : String?)throws ->Course{
            var course : Course
                  switch Input
                {
                  case "A" :
                      course = .A
                  case "B" :
                      course = .B
                  case "C" :
                      course = .C
                  case "D" :
                      course = .D
                  case "E" :
                      course = .E
                  case "F" :
                      course = .F
                  default :
                      throw InputError.InvalidCourse
                  }
            return course
        }
        
        
        
        while true {
            
            var name : String
            var age : Int
            var address : String
            var rollNumber :Int
            
            // Get and Validate roll number
            print("Please enter roll number")
            while true {
                let str = readLine() ?? nil
                do {
                    rollNumber = try getValidRollNumber(str)
                    break
                }
                catch InputError.EmptyRollNumner
                {
                    print("Roll Number cannot be empty , please enter a roll number")
                }
                catch InputError.DuplicateRollNumber
                {
                    print("This roll number already exists , please enter another roll number ")
                }
                catch InputError.InvalidRollNumber{
                    print("Invalid Roll number please enter a valid roll number")
                }
                catch {
                    print("An unknown error occurred: \(error)")
                }
            }
            
            
            // Get Name
            print("Please enter name")
            while true {
                let str = readLine() ?? ""
                do {
                    name = try getValidName(str)
                    break
                }
                catch InputError.EmptySudentName{
                    print("Name Field cannot be empty , please enter a name")
                }
                catch {
                    print("An unknown error occurred: \(error)")
                }
            }
            
            
            // Get Age
            print("Please enter age ")
            while true {
                let str = readLine() ?? ""
                do {
                    age = try getValidAge(str)
                    break
                }
                catch InputError.EmptyStudentAge
                {
                    print("Age cannot be empty , please enter age")
                }
                catch InputError.InvalidStudentAge{
                    print("Invalid age , please enter a valid age")
                }
                catch {
                    print("An unknown error occurred: \(error)")
                }
            }
            
            // Get Address
            print("Please enter address")
            while true {
                let str = readLine() ?? ""
                do {
                    address = try getValidAddress(str)
                    break
                }
                catch InputError.EmptyAddress{
                    print("Address field cannot be empty, please enter a valid address")
                }
                catch {
                    print("An unknown error occurred: \(error)")
                }
            }
            
            
            // Course selection logic
            var i = 0
            var courseList : [Course] = []
            print("Choose atleast 4 courses from [A, B , C , D , E, F]")
            while true{
                var y : Course?
                while true {
                    var str : String?
                    str = readLine()?.uppercased() ?? " "
                    do {
                        y = try getValidCourse(str)
                        break
                    }
                    catch InputError.InvalidCourse
                    {
                        print("Invalid course , select from Courses : [A, B, C, D, E, F]")
                    }
                    catch {
                        print("An unknown error occurred: \(error)")
                    }
                }
                
                // Prevent duplicate course selections
                if(courseList.contains(y!)){
                    print("You have already selected this course select another course now")
                    continue
                }
                courseList.append(y!)
                i+=1
                if (i == 4 )
                {
                    print("You have selected 4 courses do you want to select more, Type \"Y\" , else press any key to continue")
                    let r = readLine()?.lowercased() ?? ""
                    if r != "y"
                    { break}
                }
                
                //Prompt after user has selected 4 courses
                if (i == 5)
                {
                    print("You have selected 5 courses do you want to select one more, Type \"Y\" , else press any key to continue ")
                    let r = readLine()?.lowercased() ?? ""
                    if r != "y"
                    { break}
                }
                if i == 6 {
                    print("You have selected all 6 courses !")
                    break}
            }
            
            //Add new student to the list
            students.append(Student(studentName: name , studentAge: age, studentAddress: address, studentRollNumber: rollNumber , courses: courseList))
            studentRollNo.insert(String(rollNumber))
            
            
            // Ask user if they want to add another student
            print("do you want to add other student's details ? Type \"Y\" , else press any key to continue ")
            let input = readLine() ?? ""
            if ( input.lowercased() == "y")
            { continue}
            else
            { break }
            
        }
        
        
    }
    
    
    // Displays students with optional sorting
    func displayUserDetails(_ order: SortOrder?, _ field: SortField?){
        
        //Sort function to sort the students array bassed on the user's choice of order and field
        func sort<T: Comparable>(by keyPath: KeyPath<Student, T>, order: SortOrder) {
            students.sort {
                let lhs = $0[keyPath: keyPath]
                let rhs = $1[keyPath: keyPath]
                return order == .ascending ? lhs < rhs : lhs > rhs
            }
        }
        
       // calling sort function based on user's choice
        if let order = order, let field = field {
             switch field {
             case .name:
                 sort(by: \Student.studentName, order: order)
             case .age:
                 sort(by: \Student.studentAge, order: order)
             case .rollNumber:
                 sort(by: \Student.studentRollNumber, order: order)
             case .address:
                 sort(by: \Student.studentAddress, order: order)
             }
         }
     else {
             // Default sort by name ascending
             students.sort {
                    if $0.studentName == $1.studentName {
                        return $0.studentRollNumber < $1.studentRollNumber
                    } else {
                        return $0.studentName < $1.studentName
                    }
                }
         }

     

         
        // Print table header
        print(String(repeating: "-", count: 100))
        print("\(String("Name".padding(toLength: 20, withPad: " ", startingAt: 0)))" +
              "\(String("Roll Number".padding(toLength: 15, withPad: " ", startingAt: 0)))" +
              "\(String("Age".padding(toLength: 5, withPad: " ", startingAt: 0)))" +
              "\(String("Address".padding(toLength: 30, withPad: " ", startingAt: 0)))" +
              "\(String("Courses".padding(toLength: 20, withPad: " ", startingAt: 0)))")
        
        print(String(repeating: "-", count: 100))
        
        
        // Print student details
        for student in students {
            let name = (student.studentName).padding(toLength: 20, withPad: " ", startingAt: 0)
            let roll = String(student.studentRollNumber).padding(toLength: 15, withPad: " ", startingAt: 0)
            let age = String(student.studentAge).padding(toLength: 5, withPad: " ", startingAt: 0)
            let address = (student.studentAddress).padding(toLength: 30, withPad: " ", startingAt: 0)
            let courses = (student.courses ?? []).map { "\($0)" }.joined(separator: ", ").padding(toLength: 20, withPad: " ", startingAt: 0)
            
            
            print("\(name)\(roll)\(age)\(address)\(courses)")
        }
        
        print(String(repeating: "-", count: 100))
        
        
    }
    
    // Delete student by roll number
    func deleteUserDetails(){
        print("Enter roll number for the sudent whose entry you want to delete")
        let x = Int (readLine() ?? "") ?? 0
        var i = 0
        var f = 0
        for student in students {
            if student.studentRollNumber == x {
                students.remove(at: i)
                studentRollNo.remove(String(x))
                print("Deleted successfully")
                f = 1
                break
            }
            i+=1
        }
        if f == 0 {
            print("Roll number doesn't exist!")

        }
        
        
    }
    
    func getStudents() -> [Student] {
            return students
        }
    
}

class SaveDetail {
    
    // File URL for storing data
    
     var dataFileURL: URL {
        let fm = FileManager.default
        let docs = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docs.appendingPathComponent("students.json")
    }
    
    
    
    //Method save student list in JSON format
        func saveUserDetails(_ students: [Student]){
            
            do {
                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    let data = try encoder.encode(students)
                    try data.write(to: dataFileURL)
                    print("Student details saved successfully to \(dataFileURL.path)")
                } catch {
                    print("Failed to save student details: \(error)")
                }
            
        }
      
    
    // Method to load student list from JSON file
    func loadUserDetails()-> ([Student], Set<String>){
        do {
            let data = try Data(contentsOf: dataFileURL)
            let decoder = JSONDecoder()
            let students = try decoder.decode([Student].self, from: data)
            
            // Sync roll numbers to prevent duplicates
            let studentRollNo = Set(students.compactMap { $0.studentRollNumber }.map { String($0) })
            
            print("Loaded \(students.count) students from disk.")
            return (students , studentRollNo)
        } catch {
            print("No existing student data found or failed to load: \(error)")
            return ([], [])
        }
        
    }
    
    //Method to clear data from file
    func clearDataFile() {
            do {
                try Data().write(to: dataFileURL)
                print("JSON file cleared successfully.")
                let studentdetail2 = SaveDetail()
                let (loadedStudents , rollNo) = studentdetail2.loadUserDetails()
                let studentdetail = StudenDetailManager(students: loadedStudents , studentRollNo : rollNo )
            } catch {
                print("Failed to clear file: \(error)")
            }
        }

    }
    

//Menu class
class Menu{
    
    // Funtion to start display all the menu options and call the respective menu functions based on user's input
    func startMenu(){
        let studentdetail2 = SaveDetail()
        let (loadedStudents , rollNo) = studentdetail2.loadUserDetails()
        let studentdetail = StudenDetailManager(students: loadedStudents , studentRollNo : rollNo )
        
        
        while true{
            
            // Displaying Menu with all the functions that user can call
            print("Select one of the options from the below menu : ")
            print("1 - Add user detail")
            print("2 - Display user detail")
            print("3 - Delete User detail")
            print("4 - Save User detail")
            print("5 - Clear the file content")
            
            let x = readLine() ?? ""
            if Int(x) == 1
            {
                studentdetail.addUserDetails() // calling function to add user details
            }
            if Int(x) == 2
            {
                var input1 : SortOrder?
                var input2 : SortField?
                print("do you want to sort in ascending or descsending , type \"y\", else press any key to continue by default results are sorted by name")
                let input = readLine() ?? ""
                if input.lowercased() == "y"
                {
                    print("Type asc - Ascedning / desc - Descending")
                    let a = readLine()?.lowercased() ?? ""
                    print("Sort by name , age , roll_no , address")
                    let b = readLine()?.lowercased() ?? ""
                    
                    switch a
                    {
                    case "asc":
                        input1 = .ascending
                    case "desc":
                        input1 = .descending
                    default :
                        input1 = nil
                    }
                    
                    switch b
                    {
                    case "name":
                        input2 = .name
                    case "rollno":
                        input2 = .rollNumber
                    case "age":
                        input2 = .age
                    case "address":
                        input2 = .address
                    default :
                        input2 = nil
                    }
                }
                studentdetail.displayUserDetails(input1 , input2) // calling function to display user details
            }
            
            if Int(x) == 3
            {
                studentdetail.deleteUserDetails() // calling funtion to delete user details
            }
            
            if Int(x) == 4
            {
                studentdetail2.saveUserDetails(studentdetail.getStudents()) // calling function to save user details
            }
            
            if Int(x) == 5
            {
                studentdetail2.clearDataFile() // calling funtion to clear the data in JSON file or to remove all enteries saved in disk so far
            }
            print("Do you want to perform any other function , Type \"Y\" , else press any key to continue")
            
            let y = readLine()?.lowercased() ?? ""
            if y == "y"
            {
                continue
            }
            else
            {
                break
            }
            
        }
    }
    }

//Program Entry Point
var obj = Menu()
obj.startMenu()
