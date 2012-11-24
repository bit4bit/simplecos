# Copyright (C) 2012 Bit4Bit <bit4bit@riseup.net>
#
#
# This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

class Consumers::SessionsController < Devise::SessionsController
  layout "sign_in"

  def after_sign_in_path_for(resource)
    consumers_consumer_index_url
  end

  def after_sign_out_path_for(resource)
    new_consumers_client_session_url
  end
  
end

