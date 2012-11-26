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
require 'spec_helper'
require 'fileutils'
require 'zlib'

describe XmlCdrJob do
  fixtures :freeswitches
  fixtures :public_carriers
  fixtures :public_cash_plans

  before(:each) do
    @xml_data = "<?xml version=\"1.0\"?>\n  <cdr core-uuid=\"5726d938-37c3-11e2-9f54-ab820864671e\">\n    <channel_data>\n      <state>CS_REPORTING</state>\n      <direction>inbound</direction>\n      <state_number>11</state_number>\n      <flags>0=1;1=1;3=1;36=1;37=1;39=1;42=1;49=1;52=1;72=1</flags>\n      <caps>1=1;2=1;3=1;4=1;5=1;6=1</caps></channel_data>\n    <variables><simplecos_cash_plan>1</simplecos_cash_plan><nibble_account>3</nibble_account>\n      <direction>inbound</direction>\n      <uuid>5a7c446c-37cb-11e2-a088-ab820864671e</uuid>\n      <session_id>23</session_id>\n      <sip_from_user>2000</sip_from_user>\n      <sip_from_uri>2000%40192.168.1.100</sip_from_uri>\n      <sip_from_host>192.168.1.100</sip_from_host>\n      <channel_name>sofia/external/2000%40192.168.1.100</channel_name>\n      <sip_local_network_addr>192.168.1.100</sip_local_network_addr>\n      <sip_network_ip>192.168.1.6</sip_network_ip>\n      <sip_network_port>5060</sip_network_port>\n      <sip_received_ip>192.168.1.6</sip_received_ip>\n      <sip_received_port>5060</sip_received_port>\n      <sip_via_protocol>udp</sip_via_protocol>\n      <sip_from_user_stripped>2000</sip_from_user_stripped>\n      <sofia_profile_name>external</sofia_profile_name>\n      <recovery_profile_name>external</recovery_profile_name>\n      <sip_req_user>8888</sip_req_user>\n      <sip_req_port>5080</sip_req_port>\n      <sip_req_uri>8888%40192.168.1.100%3A5080</sip_req_uri>\n      <sip_req_host>192.168.1.100</sip_req_host>\n      <sip_to_user>8888</sip_to_user>\n      <sip_to_uri>8888%40192.168.1.100</sip_to_uri>\n      <sip_to_host>192.168.1.100</sip_to_host>\n      <sip_contact_user>2000</sip_contact_user>\n      <sip_contact_port>5060</sip_contact_port>\n      <sip_contact_uri>2000%40192.168.1.6%3A5060</sip_contact_uri>\n      <sip_contact_host>192.168.1.6</sip_contact_host>\n      <sip_via_host>192.168.1.6</sip_via_host>\n      <sip_via_port>5060</sip_via_port>\n      <sip_via_rport>5060</sip_via_rport>\n      <max_forwards>70</max_forwards>\n      <ep_codec_string>PCMU%408000h%4020i%4064000b,GSM%408000h%4020i%4013200b,PCMA%408000h%4020i%4064000b,G722%408000h%4020i%4064000b</ep_codec_string>\n      <call_uuid>5a7c446c-37cb-11e2-a088-ab820864671e</call_uuid>\n      <sip_use_codec_name>PCMU</sip_use_codec_name>\n      <sip_use_codec_rate>8000</sip_use_codec_rate>\n      <sip_use_codec_ptime>20</sip_use_codec_ptime>\n      <read_codec>PCMU</read_codec>\n      <read_rate>8000</read_rate>\n      <write_codec>PCMU</write_codec>\n      <write_rate>8000</write_rate>\n      <local_media_ip>192.168.1.100</local_media_ip>\n      <local_media_port>17682</local_media_port>\n      <advertised_media_ip>192.168.1.100</advertised_media_ip>\n      <sip_use_pt>0</sip_use_pt>\n      <rtp_use_ssrc>1363521995</rtp_use_ssrc>\n      <endpoint_disposition>ANSWER</endpoint_disposition>\n      <sip_reinvite_sdp>v%3D0%0D%0Ao%3Dneurotec-dev%203562924531%201%20IN%20IP4%20192.168.1.6%0D%0As%3Dsflphone%0D%0Ac%3DIN%20IP4%20192.168.1.6%0D%0At%3D0%200%0D%0Am%3Daudio%2015070%20RTP/AVP%200%203%208%209%20110%20111%20112%20115%0D%0Aa%3Drtpmap%3A0%20PCMU/8000%0D%0Aa%3Drtpmap%3A3%20GSM/8000%0D%0Aa%3Drtpmap%3A8%20PCMA/8000%0D%0Aa%3Drtpmap%3A9%20G722/8000%0D%0Aa%3Drtpmap%3A110%20speex/8000%0D%0Aa%3Drtpmap%3A111%20speex/16000%0D%0Aa%3Drtpmap%3A112%20speex/32000%0D%0Aa%3Drtpmap%3A115%20celt/32000%0D%0Aa%3Dsendonly%0D%0A</sip_reinvite_sdp>\n      <switch_r_sdp>v%3D0%0D%0Ao%3Dneurotec-dev%203562924531%201%20IN%20IP4%20192.168.1.6%0D%0As%3Dsflphone%0D%0Ac%3DIN%20IP4%20192.168.1.6%0D%0At%3D0%200%0D%0Am%3Daudio%2015070%20RTP/AVP%200%203%208%209%20110%20111%20112%20115%0D%0Aa%3Drtpmap%3A0%20PCMU/8000%0D%0Aa%3Drtpmap%3A3%20GSM/8000%0D%0Aa%3Drtpmap%3A8%20PCMA/8000%0D%0Aa%3Drtpmap%3A9%20G722/8000%0D%0Aa%3Drtpmap%3A110%20speex/8000%0D%0Aa%3Drtpmap%3A111%20speex/16000%0D%0Aa%3Drtpmap%3A112%20speex/32000%0D%0Aa%3Drtpmap%3A115%20celt/32000%0D%0Aa%3Dsendonly%0D%0A</switch_r_sdp>\n      <remote_media_ip>192.168.1.6</remote_media_ip>\n      <remote_media_port>15070</remote_media_port>\n      <sip_audio_recv_pt>0</sip_audio_recv_pt>\n      <dtmf_type>info</dtmf_type>\n      <sip_local_sdp_str>v%3D0%0Ao%3DFreeSWITCH%201353918049%201353918051%20IN%20IP4%20192.168.1.100%0As%3DFreeSWITCH%0Ac%3DIN%20IP4%20192.168.1.100%0At%3D0%200%0Am%3Daudio%2017682%20RTP/AVP%200%0Aa%3Drtpmap%3A0%20PCMU/8000%0Aa%3DsilenceSupp%3Aoff%20-%20-%20-%20-%0Aa%3Dptime%3A20%0Aa%3Dsendrecv%0A</sip_local_sdp_str>\n      <sip_to_tag>vtyg5NjmHSH0H</sip_to_tag>\n      <sip_from_tag>00d7a6bb-0e7a-4585-822e-e23321a355a2</sip_from_tag>\n      <sip_cseq>29123</sip_cseq>\n      <sip_call_id>6de58ceb-fb5d-4258-9af1-035e370dd9e9</sip_call_id>\n      <sip_full_via>SIP/2.0/UDP%20192.168.1.6%3A5060%3Brport%3D5060%3Bbranch%3Dz9hG4bKPja76de5fa-75c2-4466-ab4e-bc20aeb77ef4</sip_full_via>\n      <sip_full_from>%3Csip%3A2000%40192.168.1.100%3E%3Btag%3D00d7a6bb-0e7a-4585-822e-e23321a355a2</sip_full_from>\n      <sip_full_to>%3Csip%3A8888%40192.168.1.100%3E%3Btag%3Dvtyg5NjmHSH0H</sip_full_to>\n      <playback_seconds>1</playback_seconds>\n      <playback_ms>1119</playback_ms>\n      <playback_samples>8953</playback_samples>\n      <sound_prefix>/usr/local/freeswitch/sounds/es/mx/maria</sound_prefix>\n      <current_application>hangup</current_application>\n      <hangup_cause>NORMAL_CLEARING</hangup_cause>\n      <hangup_cause_q850>16</hangup_cause_q850>\n      <digits_dialed>none</digits_dialed>\n      <start_stamp>2012-11-26%2013%3A15%3A31</start_stamp>\n      <profile_start_stamp>2012-11-26%2013%3A15%3A31</profile_start_stamp>\n      <answer_stamp>2012-11-26%2013%3A15%3A31</answer_stamp>\n      <hold_stamp>2012-11-26%2013%3A15%3A31</hold_stamp>\n      <progress_media_stamp>2012-11-26%2013%3A15%3A31</progress_media_stamp>\n      <hold_events>%7B%7B1353935731241372,1353935735842796%7D%7D</hold_events>\n      <end_stamp>2012-11-26%2013%3A15%3A35</end_stamp>\n      <start_epoch>1353935731</start_epoch>\n      <start_uepoch>1353935731060826</start_uepoch>\n      <profile_start_epoch>1353935731</profile_start_epoch>\n      <profile_start_uepoch>1353935731060826</profile_start_uepoch>\n      <answer_epoch>1353935731</answer_epoch>\n      <answer_uepoch>1353935731120830</answer_uepoch>\n      <bridge_epoch>0</bridge_epoch>\n      <bridge_uepoch>0</bridge_uepoch>\n      <last_hold_epoch>1353935731</last_hold_epoch>\n      <last_hold_uepoch>1353935731241371</last_hold_uepoch>\n      <hold_accum_seconds>0</hold_accum_seconds>\n      <hold_accum_usec>0</hold_accum_usec>\n      <hold_accum_ms>0</hold_accum_ms>\n      <resurrect_epoch>0</resurrect_epoch>\n      <resurrect_uepoch>0</resurrect_uepoch>\n      <progress_epoch>0</progress_epoch>\n      <progress_uepoch>0</progress_uepoch>\n      <progress_media_epoch>1353935731</progress_media_epoch>\n      <progress_media_uepoch>1353935731120830</progress_media_uepoch>\n      <end_epoch>1353935735</end_epoch>\n      <end_uepoch>1353935735840839</end_uepoch>\n      <last_app>hangup</last_app>\n      <caller_id>%222000%22%20%3C2000%3E</caller_id>\n      <duration>4</duration>\n      <billsec>4</billsec>\n      <progresssec>0</progresssec>\n      <answersec>0</answersec>\n      <waitsec>0</waitsec>\n      <progress_mediasec>0</progress_mediasec>\n      <flow_billsec>4</flow_billsec>\n      <mduration>4780</mduration>\n      <billmsec>4720</billmsec>\n      <progressmsec>0</progressmsec>\n      <answermsec>60</answermsec>\n      <waitmsec>0</waitmsec>\n      <progress_mediamsec>60</progress_mediamsec>\n      <flow_billmsec>4780</flow_billmsec>\n      <uduration>4780013</uduration>\n      <billusec>4720009</billusec>\n      <progressusec>0</progressusec>\n      <answerusec>60004</answerusec>\n      <waitusec>0</waitusec>\n      <progress_mediausec>60004</progress_mediausec>\n      <flow_billusec>4780013</flow_billusec>\n      <sip_hangup_disposition>send_bye</sip_hangup_disposition>\n      <rtp_audio_in_raw_bytes>0</rtp_audio_in_raw_bytes>\n      <rtp_audio_in_media_bytes>0</rtp_audio_in_media_bytes>\n      <rtp_audio_in_packet_count>0</rtp_audio_in_packet_count>\n      <rtp_audio_in_media_packet_count>0</rtp_audio_in_media_packet_count>\n      <rtp_audio_in_skip_packet_count>224</rtp_audio_in_skip_packet_count>\n      <rtp_audio_in_jb_packet_count>0</rtp_audio_in_jb_packet_count>\n      <rtp_audio_in_dtmf_packet_count>0</rtp_audio_in_dtmf_packet_count>\n      <rtp_audio_in_cng_packet_count>0</rtp_audio_in_cng_packet_count>\n      <rtp_audio_in_flush_packet_count>0</rtp_audio_in_flush_packet_count>\n      <rtp_audio_in_largest_jb_size>0</rtp_audio_in_largest_jb_size>\n      <rtp_audio_out_raw_bytes>27692</rtp_audio_out_raw_bytes>\n      <rtp_audio_out_media_bytes>27692</rtp_audio_out_media_bytes>\n      <rtp_audio_out_packet_count>161</rtp_audio_out_packet_count>\n      <rtp_audio_out_media_packet_count>161</rtp_audio_out_media_packet_count>\n      <rtp_audio_out_skip_packet_count>0</rtp_audio_out_skip_packet_count>\n      <rtp_audio_out_dtmf_packet_count>0</rtp_audio_out_dtmf_packet_count>\n      <rtp_audio_out_cng_packet_count>0</rtp_audio_out_cng_packet_count>\n      <rtp_audio_rtcp_packet_count>0</rtp_audio_rtcp_packet_count>\n      <rtp_audio_rtcp_octet_count>0</rtp_audio_rtcp_octet_count></variables>\n    <app_log>\n      <application app_name=\"answer\" app_data=\"\" app_stamp=\"1353935731127045\"></application>\n      <application app_name=\"phrase\" app_data=\"msgcount,10\" app_stamp=\"1353935731130769\"></application>\n      <application app_name=\"sleep\" app_data=\"1000\" app_stamp=\"1353935731146529\"></application>\n      <application app_name=\"hangup\" app_data=\"\" app_stamp=\"1353935735842619\"></application></app_log>\n    <hold-record>\n      <hold on=\"1353935731241372\" off=\"1353935735842796\"></hold></hold-record>\n    <callflow dialplan=\"XML\" unique-id=\"5a7f678c-37cb-11e2-a089-ab820864671e\" profile_index=\"1\">\n      <extension name=\"test\" number=\"8888\">\n        <application app_name=\"answer\" app_data=\"\"></application>\n        <application app_name=\"phrase\" app_data=\"msgcount,10\"></application>\n        <application app_name=\"hangup\" app_data=\"\"></application></extension>\n      <caller_profile>\n        <username>2000</username>\n        <dialplan>XML</dialplan>\n        <caller_id_name>2000</caller_id_name>\n        <caller_id_number>2000</caller_id_number>\n        <callee_id_name></callee_id_name>\n        <callee_id_number></callee_id_number>\n        <ani>2000</ani>\n        <aniii></aniii>\n        <network_addr>192.168.1.6</network_addr>\n        <rdnis></rdnis>\n        <destination_number>8888</destination_number>\n        <uuid>5a7c446c-37cb-11e2-a088-ab820864671e</uuid>\n        <source>mod_sofia</source>\n        <context>public</context>\n        <chan_name>sofia/external/2000@192.168.1.100</chan_name></caller_profile>\n      <times>\n        <created_time>1353935731060826</created_time>\n        <profile_created_time>1353935731060826</profile_created_time>\n        <progress_time>0</progress_time>\n        <progress_media_time>1353935731120830</progress_media_time>\n        <answered_time>1353935731120830</answered_time>\n        <bridged_time>0</bridged_time>\n        <last_hold_time>1353935731241371</last_hold_time>\n        <hold_accum_time>0</hold_accum_time>\n        <hangup_time>1353935735840839</hangup_time>\n        <resurrect_time>0</resurrect_time>\n        <transfer_time>0</transfer_time></times></callflow></cdr>\n"

    @j = XmlCdrJob.new(@xml_data, 'test_')
    @cdr = (Hash.from_xml @xml_data)['cdr']
    @j.send :create_directories, '3', @cdr
  end

  after(:each) do
    begin FileUtils.rm_r(Rails.root.join('test_cdr')) ;rescue; end
  end
  
  it "should parse xml data" do
    @j.perform
  end
  
  it "should get cdr to save" do
    @j.send(:cdr_to_save, 3, @cdr).should eq({
                                             :account_id => 3,
                                             :signaling_ip => '192.168.1.6',
                                             :remote_media_ip => '192.168.1.6',
                                             :call_time => '2012-11-26 08:15:31 -0500',
                                             :duration => 4,
                                             :destination_number => "8888",
                                             :ani => "2000",
                                             :total_amount => 5.0
                                           })
  end
  
  it "should add cdr to day cdrs" do
    cdr_file = Rails.root.join('test_cdr', '3', '11_2012', 'day_11_2012_26.csv.gz')
    File.exists?(cdr_file).should eq(false)
    @j.send(:cdr_day, 3, @cdr)
    File.exists?(Rails.root.join('test_cdr', '3', '11_2012', 'day_11_2012_26.csv.gz')).should eq(true)
  end

  it "should add cdr and read to day cdrs" do
    pending "Not work, but if i cat the file the data is there..what happend??"
    cdr_file = Rails.root.join('test_cdr', '3', '11_2012', 'day_11_2012_26.csv.gz')
    @j.send(:cdr_day, 3, @cdr)
    gz = Zlib::GzipReader.new(File.open(cdr_file,'r'))
    CSV.parse_line(gz.readline).should eq(['account_id',
                                         'signaling_ip',
                                         'remote_media_ip',
                                         'call_time',
                                         'duration',
                                         'destination_number',
                                         'ani',
                                         'total_amount'
                                        ])
    CSV.parse_line(gz.readline).should eq([3,
                                           '192.168.1.6',
                                           '192.168.1.6',
                                           '2012-11-26 08:15:31 -0500',
                                           4,
                                           "8888",
                                           "2000",
                                           0.6666666666666666
                                           ])
                                           
    gz.close
  end
  
  it "should add cdr to month cdrs" do
    cdr_file = Rails.root.join('test_cdr', '3', '11_2012', 'month_11_2012.csv.gz')
    File.exists?(cdr_file).should eq(false)
    @j.send(:cdr_month, 3, @cdr)
    File.exists?(Rails.root.join('test_cdr', '3', '11_2012', 'month_11_2012.csv.gz')).should eq(true)
  end
  
  it "should add cdr to week of month cdr" do
    File.exists?(Rails.root.join('test_cdr', '3', '11_2012', 'week_2012_48.csv.gz')).should eq(false)
    @j.send(:cdr_week, 3, @cdr)
    File.exists?(Rails.root.join('test_cdr', '3', '11_2012', 'week_2012_48.csv.gz')).should eq(true)
  end
  
  
  it "should clean day of month past" do
    @j.send(:clean_days_of_month_past, 3, @cdr).should eq(true)
    @j.send(:cdr_month, 3, @cdr)
    @j.send(:clean_days_of_month_past, 3, @cdr).should eq(false)
  end
  
  it "should calculte amount billaret 10" do
    cdr = {"variables" => {"simplecos_cash_plan" => "1", "billsec" => "25"}}
    @j.send(:calculate_total_amount, cdr).should eq(5)

    cdr = {"variables" => {"simplecos_cash_plan" => "1", "billsec" => "50"}}
    @j.send(:calculate_total_amount, cdr).should eq(10)
    

    cdr = {"variables" => {"simplecos_cash_plan" => "1", "billsec" => "70"}}
    @j.send(:calculate_total_amount, cdr).should eq(15)

    cdr = {"variables" => {"simplecos_cash_plan" => "1", "billsec" => "91"}}
    @j.send(:calculate_total_amount, cdr).should eq(20)
      
  end

 it "should calculte amount bill rate 100" do
    cdr = {"variables" => {"simplecos_cash_plan" => "2", "billsec" => "25"}}
    @j.send(:calculate_total_amount, cdr).should eq(50)

    cdr = {"variables" => {"simplecos_cash_plan" => "2", "billsec" => "50"}}
    @j.send(:calculate_total_amount, cdr).should eq(100)
    

    cdr = {"variables" => {"simplecos_cash_plan" => "2", "billsec" => "70"}}
    @j.send(:calculate_total_amount, cdr).should eq(150)

    cdr = {"variables" => {"simplecos_cash_plan" => "2", "billsec" => "91"}}
    @j.send(:calculate_total_amount, cdr).should eq(200)
      
  end

  
end

