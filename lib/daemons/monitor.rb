#!/usr/bin/env ruby1.9.1

if ENV["RAILS_ENV"] != "test"


# You might want to change this
ENV["RAILS_ENV"] ||= "development"

root = File.expand_path(File.dirname(__FILE__))
root = File.dirname(root) until File.exists?(File.join(root, 'config'))
Dir.chdir(root)

require File.join(root, "config", "environment")
require 'celluloid/autostart'

$running = true
Signal.trap("TERM") do 
  $running = false
end

# Monitorea estados del cliente
# actualmente solo se monitorea el balance
# y se envia el correo
class ClientMonitor
  include Celluloid
  include Celluloid::Logger


  def initialize(client)
    @client = client
    @notified_balance_out = false
    @notified_balance_in = false
  end

  def notify_balance_out
    info "Testing balance out for client #{@client.name}"
    return false if @client.balance > 1 or @notified_balance_out == true
    info "Balance out: sending email"
    @notified_balance_out = true
    @notified_balance_in = false
    UserMailer.balance_out_email(@client).deliver
  end
  
  def notify_balance_in
    info "Testing balance in for client #{@client.name}"
    return false if @client.balance < 1 or @notified_balance_out == false or @notified_balance_in == true
    @notified_balance_in = true
    @notified_balance_out = false
    info "Balance in: sending email"
    UserMailer.balance_in_email(@client).deliver
  end
  
  def run
    while($running) do
      @client = @client.reload
      notify_balance_out
      notify_balance_in
      ActiveRecord::Base.connection.close
      sleep 60
    end
  end
    
end

client_monitors = {}
while($running) do
  ActiveRecord::Base.establish_connection


  Client.all.each do |client|
    next if client_monitors.include?(client.id)
    Rails.logger.info "Monitoring client #{client.name}"
    client_monitor = ClientMonitor.new(client)
    client_monitors[client.id] = client_monitor
    client_monitor.async.run
  end

  
  Celluloid.logger = Rails.logger
  Rails.logger.info "This daemon is still running at #{Time.now}.\n"
  
  sleep 300
end

end
