require 'rubygems'
require 'taza/page'

module Sourcing
  class SearchPage < ::Taza::Page

      element(:submit_btn)              { browser.button(:class => 'btn btn-success searchbutton full-width hidden-sm').when_present }
      element(:profession_input)        { browser.input(:id, 'profession').when_present }
      element(:row_result)              { browser.divs(:class, 'row result') }

  end
end
