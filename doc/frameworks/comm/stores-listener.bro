const broker_port: port &redef;
redef exit_only_after_terminate = T;

global h: opaque of Store::Handle;
global expected_key_count = 4;
global key_count = 0;

function do_lookup(key: string)
	{
	when ( local res = Store::lookup(h, Comm::data(key)) )
		{
		++key_count;
		print "lookup", key, res;

		if ( key_count == expected_key_count )
			terminate();
		}
	timeout 10sec
		{ print "timeout", key; }
	}

event ready()
	{
	h = Store::create_clone("mystore");

	when ( local res = Store::keys(h) )
		{
		print "clone keys", res;
		do_lookup(Comm::refine_to_string(Comm::vector_lookup(res$result, 0)));
		do_lookup(Comm::refine_to_string(Comm::vector_lookup(res$result, 1)));
		do_lookup(Comm::refine_to_string(Comm::vector_lookup(res$result, 2)));
		do_lookup(Comm::refine_to_string(Comm::vector_lookup(res$result, 3)));
		}
	timeout 10sec
		{ print "timeout"; }
	}

event bro_init()
	{
	Comm::enable();
	Comm::subscribe_to_events("bro/event/ready");
	Comm::listen(broker_port, "127.0.0.1");
	}
