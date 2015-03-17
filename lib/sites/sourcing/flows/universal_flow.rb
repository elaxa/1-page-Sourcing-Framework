require 'rubygems'

module Sourcing
  class Sourcing < ::Taza::Site

    def jq_based_waiter (where = "N/A")
      t1 = Time.now
      Watir::Wait.until(30) { browser.execute_script("return jQuery.active") == 0}
      t2 = Time.now
      puts "#{where} took #{(t2-t1).round(2)} milliseconds" unless where == 'N/A'
    end

    alias :jqw :jq_based_waiter

  end
end