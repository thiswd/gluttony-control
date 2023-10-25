# Gluttony Control API

Gluttony Control API is a project that leverages the data from [Open Food Facts](https://world.openfoodfacts.org/), an open database of food products with nutritional information. This project serves as a conduit for accessing and manipulating said data in a structured manner.

## Technologies Used

- **Language**: Ruby 3.2.2
- **Framework**: Ruby on Rails 7.1.1
- **Database**: PostgreSQL 15.3
- **Test**: RSpec, FactoryBot, Shoulda-Matchers
- **Others**: Docker, Swagger, Kaminari, Rubocop, Whenever, Sys-proctable

## Setting Up the Project

### Clone the Repository:

```sh
git clone git@github.com:thiswd/gluttony-control.git
cd gluttony-control
```

### Install Dependencies:

```sh
bundle install
```

### Setup Database:

```sh
rails db:create
rails db:migrate
```
## Running the Project

### Using Docker:

```sh
docker-compose up --build
```

### Using the Terminal:
Start the Rails server:

```sh
rails s
```

## Data Import via Rake Task

You can import product data using the custom rake task provided. Here's how:

```sh
rails import:open_food_facts[NUMBER_OF_RECORDS]
```
Replace `NUMBER_OF_RECORDS` with the number of records you wish to import from each file. If you do not specify a number, it will default to 100 records per file.

## Running the Tests

To run the test suite, execute:

```sh
rspec .
```

## Authentication

To access the endpoints of this API, you need an API key. To generate one, run the following task:

```sh
rails generate:api_key
```

Once the task is complete, it will display your new API key. Make sure to keep it safe.

When making requests to the API, you'll need to include your API key in the request headers:

- Key: X-API-KEY
- Value: YourGeneratedApiKey

## Testing the API with Swagger

Navigate to `http://localhost:3000/api-docs/`

## Design Decisions

### Database

- **PostgreSQL:** Opted for a relational database due to my familiarity with such systems. PostgreSQL offers efficiency and a seamless integration with Rails.

- **Products Table**: An index was added to the `code` column since this attribute is frequently queried in the `show`, `update`, and `destroy` routes of the API.

- **ImportHistories Table**: This table keeps track of each import process, logging the filename, status, the number of records processed, the number of records successfully imported, and error details if any issues arise during the import.

### Data Import Process

The data importation was segmented into three distinct parts to ensure clarity, maintainability, and error handling:

1. **Downloading** the data file:

   - `Downloader` class handles the downloading process.
   - It makes a request to a given URL and saves the data to a specified local path.

2. **Extracting** records from the compressed data file:

   - `Extractor` class manages the data extraction from compressed files.
   - Instead of extracting every single record, this class only extracts a predefined number of records, optimizing the extraction process. This means, if you only want a sample or if you're testing, you don't have to process huge files unnecessarily.

3. **Importing** records into the database:

   - `ProductImporter` class is responsible for reading each product from the file and processing it into the database.
   - Every product processed, whether successfully imported or not, is logged in the `ImportHistories` table. This provides a transparent view of the import process and helps diagnose any issues.

### Rake Task for Data Import

A rake task named `import:open_food_facts` was defined to automate the process of data importation. This task:

- Fetches the latest filenames from the Open Food Facts API.
- Downloads, extracts, and imports data from each file.
- Allows setting a limit on the number of records to process via the `limit_records` variable. This is particularly useful during development or testing phases, avoiding the need to process large files every time.

### Dynamic Filename Fetching

A distinct class was established to always request the filename data from the Open Food Facts API. This ensures that the application always has the most up-to-date filenames, taking into account any changes or updates on the API's end.

### Scheduled Imports using Whenever

The `whenever` gem was integrated to manage scheduled tasks via Cron. The data import task is set to run every day at 4:13 am, ensuring that the application always has the freshest data without manual intervention.

### System Status Endpoint

The root endpoint (`/`) serves as a quick system status check for the API. It provides essential information, such as:

- Database connectivity
- The last cron job's run timestamp
- System uptime
- Memory usage

To retrieve the system's memory usage, the `sys-proctable` gem was employed due to its comprehensive process table inspection capability.

### Product Index Endpoint

For product listing and pagination, the `kaminari` gem was chosen. This gem offers an intuitive interface for paginating ActiveRecord models and provides helpful methods like `current_page`, `total_pages`, and `total_count`. These methods were leveraged to enhance the JSON output, making it more user-friendly and information-rich.

### Product Update Parameters

When designing the parameters allowed for product update actions, careful consideration was given to which attributes could be modified. Fields such as dates (`created_at`, `updated_at`), `status`, and `code` were intentionally excluded from permissible update parameters. This decision stemmed from the understanding that:

- Dates should be managed internally to maintain data integrity and not be altered manually.
- The `code` is a unique identifier and should remain consistent throughout the product's lifecycle.
- Modifying the `status` through general update actions could lead to unintentional changes and potential misuse.

### Switching from `URI.open` to `Net::HTTP.get_response`

We initially used `URI.open` for our HTTP requests, but during a code review, we identified potential security risks associated with it. As flagged by Rubocop, using `URI.open` can expose our application to security vulnerabilities.

To address this, we decided to leverage Ruby's built-in `Net::HTTP.get_response`. This method is more secure and gives us better control over the HTTP requests. By making this change, we not only improved the security of our application but also provided a more robust error handling mechanism.

### Introduction of `BaseHttpService` Class

During the refactoring process, it was observed that there was a repetition in the logic for making HTTP requests in multiple classes. To follow the DRY (Don't Repeat Yourself) principle and to enhance code maintainability, we introduced the `BaseHttpService` class.

This centralized class handles the logic for making HTTP requests and error handling, allowing for a consistent approach across the application. By doing this, we've made the code more modular, and future changes related to HTTP requests can be made in one place, affecting all dependent classes.

### Storing API Keys in the Database

We decided to store the API keys in our database for several reasons:

- **Flexibility**: It allows us to easily manage, revoke, or refresh keys if needed.
- **Scalability**: As our user base grows, we might want to issue different API keys with varying levels of access or rate limits. Storing them in the database makes such management straightforward.
- **Persistence**: With API keys in the database, the system remains stateful. If the server restarts or if there's a deployment, the API keys remain valid and uninterrupted.

### API Documentation with Swagger

Swagger was chosen as the tool for API documentation for several reasons:

- **Interactivity**: Swagger provides an interactive UI that allows users to explore the API and make requests, fostering a more hands-on understanding of the API's capabilities.
- **Standardization**: Swagger uses the OpenAPI Specification, which is a widely-adopted industry standard for describing RESTful APIs.
- **Clarity and Completeness**: The visual representation, coupled with structured endpoint descriptions, makes it easier for both developers and non-developers to grasp the API's functionalities.
- **Integration Ease**: Swagger's toolset integrates seamlessly with many modern development workflows, ensuring that the documentation remains up-to-date with code changes.

### Acknowledgements

This project was developed as a challenge for [Coodesh](https://coodesh.com).

 Feedback is always welcome!
