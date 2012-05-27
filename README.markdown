signantia_analysis
==================

signantia_analysis is a tool for performing frequency analysis of text corpuses.

signantia_analysis reads text files stored in a folder, uses regex to iterate over text, tallies the frequencies of each match, and stores the results in a database.

It has a number of features:

*   It uses [DataMapper](http://datamapper.org/) to interact with the database. This means that many adapters can be used, including [SQLite](http://www.sqlite.org/), [MySQL](http://www.mysql.com/), [PostgreSQL](http://www.postgresql.org/). A [SQLite](http://www.sqlite.org/) adapter is included in the `Gemfile`.
*   The same database can be used for multiple corpuses and analyses.
*   It reads all text files within a specified folder, using them to build the corpus. No special preparation of the files is needed.
*   It supports unicode, so using Russian corpuses, for example, works. ([SQLite](http://www.sqlite.org/) works fine with this, but [MySQL](http://www.mysql.com/) doesn't seem to work out-the-box.)
*   It uses [Regex](http://www.regular-expressions.info/ruby.html) to specify the matches which should be iterated over. This means that many different types of frequency analysis are possible (word, sentence, etc.).
*   Files can be added to the corpus and the tool re-run. If using the same database, the tool will detect those files which have already been analysed with that regex, and effectively use a cached result, rather than performing the analysis again.
*   It is well-tested, using [RSpec](http://relishapp.com/rspec). This gives a degree of confidence in the results. [factory_girl](https://github.com/thoughtbot/factory_girl) is used wherever reasonably possible, and fixtures are used to test the accuracy of the analysis itself (a small corpus is included).

Getting Started
---------------

1.  Install dependencies using [RubyGems](http://rubygems.org/) and the `Gemfile` included. If you are using [RVM](https://rvm.beginrescueend.com/), then the `.rvmrc` will automatically create a gemset (called signantia_analysis), `gem install bundler`, and `bundle install`.

2.  Create a folder to act as a corpus, containing text files. Fewer large files are processed much quicker than more small files. This is because the tool uses an in-memory hash whilst analysing a file, and then synchronises the results to the database after each file. Because the number of objects being synchronised affects the time taken for this stage, using larger files will increase the chances of matches with higher frequencies being stored in the hash, decreasing the overall number of objects and thus the time spent using the database.

3.  In the root folder of the repository, run the tool from the command-line with something like:

        ./bin/signantia_analysis --database "sqlite:/home/user/example.sqlite3" --corpus "/home/user/corpus/" --regex "/[\S]+/"

    This will tally the frequencies of each word in the corpus.

4.  Interrogate the database using some tool such as `sqlite3` for [SQLite](http://www.sqlite.org/).

Run `./bin/signantia_analysis --help` to see a list of parameters.

Contributing
------------

Contributions are encouraged! Please fork the repository and write your code, ensuring that no tests are broken by the changes, and that new tests are added to cover the new functionality. Then send a pull request.

Credits
-------

signantia_analysis was written by [@tiredpixel](http://coderwall.com/tiredpixel), for [signantia](http://signantia.com).

![](http://signantia.com/images/signantia_logo.png)

[signantia](http://signantia.com) provides free and cheap online language-learning tools.

License
-------

© signantia.com & @tiredpixel 2012. It is free software, released under the MIT License, and may be redistributed under the terms specified in `LICENSE`.
