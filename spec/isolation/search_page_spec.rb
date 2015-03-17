require 'spec_helper'

describe "SearchPage" do

  it "should open search page" do
    @sourcing.browser.goto (@sourcing_url[:search])
    sleep 2
    @sourcing.search_page.submit_btn.present?.should be true
  end

  it "should be able to search by profession" do |s|

    profession = 'Quality Engineer'

    s.step "Given that profession is #{profession}" do
    end

    s.step "And search field is populated with #{profession}" do
      @sourcing.search_page.profession_input.send_keys profession
    end

    s.step "And 'Submit' button is clicked" do
      @sourcing.search_page.submit_btn.click
      sleep 11 #TODO remove sleep
    end

    s.step 'Then 2 results are displayed' do
      @sourcing.search_page.row_result.size.equal? 2
    end

  end




end
