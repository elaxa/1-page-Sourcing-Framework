# Testing Framework for Sourcing
BDD Testing Framework with RSpec, Watir &amp; Taza

1. Make sure Install RVM on your machine
2. Use RVM to install ruby with command rvm install ruby-2.0.0-p598 
3. Install bundle 
4. Once bundle is installed clone the repository from git with command: git clone git@github.com:1-Page/sourcing-test-framework.git 
5. cd sourcing-test-framework
6. If RVM is install get a message: 
  ```
You are using '.rvmrc', it requires trusting, it is slower and it is not compatible with other ruby managers,
you can switch to '.ruby-version' using 'rvm rvmrc to ruby-version'
or ignore this warning with 'rvm rvmrc warning ignore /Users/Rodion/Documents/Projects/sourcing-test-framework/.rvmrc',
'.rvmrc' will continue to be the default project file in RVM 1 and RVM 2,
to ignore the warning for all files run 'rvm rvmrc warning ignore all.rvmrcs'.

Using /Users/Rodion/.rvm/gems/ruby-2.0.0-p598
```
7. Install taza gem locally on your machine. I modified that gem a bit, so it needs to get installed locally using command
  ```
gem install --local taza-0.9.2.1.gem
```
8. run: ```bundle install```
9. run: ```rspec spec/isolation/search_page_spec.rb```
10. FF browser opens and run the tests
11. To generate reporst we need to install: Allure Plugin
12. Go here: https://github.com/allure-framework/allure-cli and use the instructions for your machine
13. To generate reports run: ```allure generate reports/allure -o reports/allure-reports -v 1.4.0```
14. Open index.html in reports/allure-reports folder using FF or run on MAC: ```open reports/allure-reports/index.html```
15. Reports should be visible: 

![alt tag](https://lh5.googleusercontent.com/M6Gaoj0upbgDlM6Uti2PgNals-p2_EyhMHrxDv2vWen5K6g-f9vQKO88u6eYQ3c97LlqUe-KTrE=w2560-h1518)
