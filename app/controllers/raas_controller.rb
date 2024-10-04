class RaasController < ApplicationController
  include Raas::Client::Rails::RaasControllerModule

  def prepare_tenant_and_sub
      super
      @tenant = "sample_tenant_id"
      @sub = "sample_user_id"
      # @sub_domain = "sample_sub_domain"
  end
end
