# Data Normaliser

Ruby script normalizing JSON and CSV data into 1 output file.

### Description
There are 3 input data files:

* journals.csv: a list of journal titles and ISSNs;
* articles.csv: a list of article DOIs, titles and ISSNs;
* authors.json: a list of author names and their article DOIs.

The script combines these data files and outputs a single text file in one of two
different formats:

* CSV with columns of DOI, Article title, Author name, Journal title and
  Journal ISSN, e.g.

      10.1234/altmetric0,Small Wooden Chair,Amari Lubowitz,"Shanahan, Green and Ziemann",1337-8688

* JSON as an array of objects with fields for DOI, title, author, journal and
  ISSN, e.g.

    {
        "doi": "10.1234/altmetric0",
        "title": "Small Wooden Chair",
        "author": "Amari Lubowitz",
        "journal": "Shanahan, Green and Ziemann",
        "issn": "1337-8688"
    }


### Using the script
The ruby program can take three files and produce the new formats by running it inside `lib` directory like so:

    $ `ruby combine.rb --format json ../resources/journals.csv ../resources/articles.csv ../resources/authors.json > full_articles.json`
    $ `ruby combine.rb --format csv ../resources/journals.csv ../resources/articles.csv ../resources/authors.json > full_articles.csv`
