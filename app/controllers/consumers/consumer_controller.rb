class Consumers::ConsumerController < Consumers::ApplicationController
  before_filter :authenticate_consumers_client!
  

  def index
  end
end
