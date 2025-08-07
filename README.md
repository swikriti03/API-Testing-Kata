# 📦 Booking API Automation Framework

A professional-grade **API automation framework** built using **Java**, **Cucumber (BDD)**, and **Rest-Assured**,
with structured logging, modular test design, and seamless integration ready for CI pipelines.

---

## ✅ Features

- 🔁 **CRUD operations** testing via Booking API
- 🧾 **Field-level validation** and **error response checks**
- 🧪 Covers:
    - `Create Booking API`
    - `Get Booking API`
    - `Update Booking API`
    - `Delete Booking API`
- 🪵 **JSON logging** via custom Rest-Assured filters with timestamp
- 🧩 **Modular & scalable** folder structure
- 📊 **Default HTML Cucumber reports**
- 📊 **Rich custom HTML Cucumber reports**
- ⚙️ **CI-ready** with Maven

---

## 🧰 Tech Stack

| Component        | Description                                  |
|------------------|----------------------------------------------|
| 🟦 **Java 17**      | Programming language                        |
| 📦 **Maven 3.9.9**  | Build and dependency management             |
| 🧪 **JUnit**        | Test runner framework                       |
| 🥒 **Cucumber**     | BDD test structure using Gherkin            |
| 🔍 **Rest Assured** | API testing library                         |
| 📜 **Gherkin**      | Human-readable test scenarios               |

---

## 🚀 Getting Started

### 🧱 Prerequisites

Ensure the following are installed:

- Java 17+
- Maven 3.9+
- IntelliJ IDEA (recommended)

### 🧩 IntelliJ Plugin Setup

- ✅ Cucumber for Java
- ✅ Gherkin

---

## 🛠️ Project Setup (IntelliJ)

1. **Clone the repository**
   ```bash
   git clone https://github.com/swikriti03/API-Testing-Kata.git
   ```

2. **Open in IntelliJ**  
   `File → Open → Select the project folder -> select the pom.xml -> open as project`

3. **Set Project SDK**  
   `File → Project Structure → Project SDK → Java 17`

4. **Enable Annotation Processing**  
   `File → Settings → Build, Execution, Deployment → Compiler → Annotation Processors`  
   ✅ Check `Enable annotation processing`

---

## 🧪 Running Tests

### 🔁 Option 1: Via Maven

```bash
mvn clean test
```

### 🔁 Option 2: From TestRunner class

Open `TestRunner.java` and run directly from IntelliJ.  
Provide the tag you want to execute against the key `FILTER_TAGS_PROPERTY_NAME`

Below tags can be combined using operators like and, or ,not:

Execute all the scenarios (default tag): @booking_regression
Execute all error validation scenarios: @error_validation
Execute end-to-end test: @e2e_scenario
Execute tests related to create booking API: @create_booking
Execute tests related to retrieve booking API: @get_booking_by_roomID
Execute tests related to update booking API: @update_booking
Execute tests related to delete booking API: @delete_booking
Execute all tests that does not require authentication: @noAuth

---

## 📂 Folder Structure Overview

```bash
src
├── main
│   └── java
│       └── com.POJO                    # POJO for serialization
├── test
│   ├── java
│   │   └── com.booking
│   │       ├── TestRunner              # Test runners
│   │       ├── utils                   # utils
│   │       └── setpDefinitions         # Step definition files
│   └── resources
│       ├── features                    # Gherkin feature files
│       ├── schemas                     # Schemas
│       └── application.properties      # properties
logs
└── logfile.txt                  # Custom JSON API logs
```

---

## 📊 Reports

After execution,
-a detailed default **Cucumber HTML report** is generated:
📁 `target/cucumber-reports-yyyyMMdd_HHmmss.html`
Open this file in your browser to see test summaries, scenarios, steps, and errors.

-a detailed custom **Cucumber HTML report folder** is generated:
📁 `target/cucumber-html-report-yyyyMMdd_HHmmss`
Open this folder in explorer & navigate inside and open overview-features.html to see test summaries, scenarios, steps, and errors.

---

## 🛠 Logging: Custom Filter

- All API request & response logs are stored in `/target/logs/logfile.txt`
- Logged in **JSON format** with timestamps
- Works for **both success and failure cases**
- Logging is handled via a custom **Rest-Assured Filter**

---

## ⚠️ Troubleshooting

| Issue                       | Solution                                  |
|-----------------------------|-------------------------------------------|
| ❌ Tests not running         | Rebuild the project or check Java version |
| ❌ Missing logs              | Look carefully into target/logs folder    |
| ❌ Red annotations           | Enable annotation processing in IntelliJ  |
| ❌ Plugin warnings           | Install/update required IntelliJ plugins  |

---

## 👩‍💻 Author

**Swikriti**  
📁 [GitHub](https://github.com/swikriti03)

---