require 'spec_helper'

describe "SearchPage" do

  it "should open search page" do
    @sourcing.browser.goto (@sourcing_url[:search])
    sleep 5
    @sourcing.search_page.submit_btn.present?.should be true
  end




end
