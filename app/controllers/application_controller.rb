# frozen_string_literal: true

class ApplicationController < ActionController::Base
    
    protected
  
    def after_sign_in_path_for(resource)
      # Check if the resource is a vendor and redirect to the dashboard
      if resource.instance_of?(Vendor)
        vendor_dashboard_path
      else
        super
      end
    end
end
