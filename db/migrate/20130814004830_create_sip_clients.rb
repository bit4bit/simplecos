class CreateSipClients < ActiveRecord::Migration
  def change
    create_table :sip_clients do |t|
      t.references :client
      t.string :sip_pass
      t.string :sip_user
      t.integer :max_calls
      t.string :proxy_media

      t.timestamps
    end
    add_index :sip_clients, :client_id

    #migra datos a nueva tabla
    Client.all.each {|client|
      params = {:sip_pass => client.sip_pass,
        :sip_user => client.sip_user,
        :max_calls => client.max_calls
      }
      if client.bypass_media
        params[:proxy_media] = 'bypass'
      elsif client.proxy_media
        params[:proxy_media] = 'media'
      end
      SipClient.new(params).save(:validate => false)
    }
  end
end
