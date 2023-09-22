# Gluttony Control API

Gluttony Control API is a project that leverages the data from [Open Food Facts](https://world.openfoodfacts.org/), an open database of food products with nutritional information. This project serves as a conduit for accessing and manipulating said data in a structured manner.

## Initial Setup

### Docker Configuration

- The project is dockerized from the get-go, ensuring consistent environment for development.
- Containers have been set up for both the Rails API and the PostgreSQL database.

### Testing Tools

- **RSpec:** Chosen for its expressiveness and ease of use, RSpec is the primary testing tool for the project.
- **FactoryBot:** A fixture replacement to simplify object creation for tests.
- **Shoulda-Matchers:** Provides simple one-liner tests for common Rails functionalities, further speeding up the test-writing process.

### Code Quality and Standards

- **Rubocop:** Ensures the code adheres to community-driven Ruby coding standards.

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

### Acknowledgements

This project was developed as a challenge for [Coodesh](https://coodesh.com).
