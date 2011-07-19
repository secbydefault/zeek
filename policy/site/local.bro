##! Template for local site policy. Customize as appropriate.

# DPD should typically be loaded for detecting protocols on any port.
@load frameworks/dpd

@load frameworks/notice
@load frameworks/signatures
@load frameworks/metrics
@load frameworks/intel
@load frameworks/software
@load frameworks/reporter

# Load a few extra scripts that aren't loaded by default.
@load frameworks/packet-filter/netstats
@load misc/loaded-scripts


@load protocols/conn
@load protocols/dns
@load protocols/ftp
@load protocols/http
@load protocols/irc
@load protocols/mime 
@load protocols/smtp
@load protocols/ssh
@load protocols/ssl
@load protocols/syslog

@load tuning/defaults

# Sample notice policy which you will almost certainly want 
# to adapt to your environment. 
	
#redef notice_action_filters +=
#    {
#	# These are all very common.
#	#[Weird::ContentGap] = tally_notice_type_and_ignore,
#	#[Weird::AckAboveHole] = tally_notice_type_and_ignore,
#	#[Weird::RetransmissionInconsistency] = tally_notice_type_and_ignore,
#	#[Drop::AddressDropIgnored] = ignore_notice,
#	#[Drop::AddressDropped] = ignore_notice,
#	#[Weird::WeirdActivity] = file_local_bro_notices,
#	#[PacketFilter::DroppedPackets] = file_notice,
#	#[TerminateConnection::TerminatingConnectionIgnored] = notice_alarm_per_orig,
#	#[ProtocolDetector::ProtocolFound] = file_notice,
#	#[ProtocolDetector::ServerFound] = file_if_remote,
#	#[DynDisable::ProtocolViolation] = file_notice,
#	};

redef Weird::weird_action += {
	["window_recision"] = Weird::WEIRD_FILE,
	["RST_with_data"] = Weird::WEIRD_FILE,
	["line_terminated_with_single_CR"] = Weird::WEIRD_FILE,
	["line_terminated_with_single_LF"] = Weird::WEIRD_FILE,
	["spontaneous_RST"] = Weird::WEIRD_FILE,
	["spontaneous_FIN"] = Weird::WEIRD_FILE,
	["data_before_established"] = Weird::WEIRD_FILE,
	["unsolicited_SYN_response"] = Weird::WEIRD_FILE,
	["inappropriate_FIN"] = Weird::WEIRD_FILE,
	["possible_split_routing"] = Weird::WEIRD_FILE,
	["connection_originator_SYN_ack"] = Weird::WEIRD_FILE,
	["fragment_inconsistency"] = Weird::WEIRD_NOTICE_PER_ORIG,
	["fragment_size_inconsistency"] = Weird::WEIRD_NOTICE_PER_ORIG,
	["fragment_overlap"] = Weird::WEIRD_NOTICE_PER_ORIG,
	["ICMP-unreachable for wrong state"] = Weird::WEIRD_NOTICE_PER_ORIG,
	["corrupt_tcp_options"] = Weird::WEIRD_NOTICE_PER_ORIG,
};
	
	
