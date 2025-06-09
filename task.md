# UK Registered Companies CSV Task

You have been provided with a CSV file that contains a sample of all the companies based in the UK.

--------

### Input CSV - columns

Here is some information on the columns contained within the file:

| Column Name                      | Column Index | Description |
| -------------------------------- | ------------ | ----------- |
| `CompanyName`                    |            0 | The company name |
| `CompanyNumber`                  |            1 | The unique company identifier |
| `RegAddress.AddressLine1`        |            4 | First line of address |
| `RegAddress.PostTown`            |            6 | Town of address |
| `RegAddress.PostCode`            |            9 | Postcode |
| `CompanyStatus`                  |           11 | Whether the company is active / liquidated etc. - possible values include: `Active`, `Active - Proposal to Strike off`, `Liquidation`, `In Administration` (we will only be filtering by `Active`) |
| ` PreviousName_1.CompanyName`    |           34 | The most recent previous name (if they had one) |

----------

### Output CSV - columns

| Column Name      | Description  |
| ---------------- | ------------ |
| `company_name`   | Company name |
| `company_number` | Unique company identifier |
| `address`        | Combined address (address line 1, post town, postcode) |
| `previous_name`  | Most recent previous name (if they had one) |

---------

### Primary Task (pt. 1)

Parse the CSV file `companies-input.csv` (within this folder), and output a new CSV containing the columns detailed above.

### Extended Task (pt. 2)

Filter by the `CompanyStatus` column and ensure only `Active` companies are included in the output CSV.

### Extended Task (pt. 3)

Find a way to make your program robust enough to identify a CSV where the columns change - either columns are removed, column headers change etc. There is a second CSV file `companies-input-pt-3.csv` which we can use in place of the original file.

### Extended Task (pt. 4)

[Here](http://download.companieshouse.gov.uk/en_output.html) is the link for the real (much larger!) datasets. Discuss how you might obtain reasonable performance over such a large file (when broken down into 6 separate files, the first one has 850,000 rows). If there is time, implement some of these suggestions and find a way to measure!
