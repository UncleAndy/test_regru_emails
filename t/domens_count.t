#!/usr/bin/perl
use Modern::Perl;

use Test::More;

require_ok('libs/domen_from_email.pm');
require_ok('libs/domens_count.pm');

ok(
    eval { domens_count::process('test1@email.com'); 1; } || 0 == 1,
    'Process method working good for email "test1@email"'
);
ok(
    eval { domens_count::process('test1@email_bad'); 1; } || 0 eq 1,
    'Process method working good for email "test1@email_bad"'
);
ok(
    eval { domens_count::process(''); 1; } || 0 eq 1,
    'Process method working good for empty email ""'
);

sub _process_set_1 {
    domens_count::clean();
    domens_count::process('test@domen1.com');
    domens_count::process('test@domen2.com');
    domens_count::process('test@domen3.com');
    domens_count::process('test@domen1.com');
    domens_count::process('test@domen1.com');
    domens_count::process('test@domen2.com');
    domens_count::process('');
    domens_count::process('test@domen1bad');
    domens_count::process('test@@@@domen1bad');
    domens_count::process('test-ttt.ttt@-^%^domen.bad');
}

sub _result_set_1 {
    return "domen1.com:\t3\ndomen2.com:\t2\ndomen3.com:\t1\nINVALID:\t3\n";
}

ok(
    eval {
        _process_set_1();
        domens_count::print_result();
    } eq _result_set_1(),
    'Result return right text for set 1'
);

sub _process_set_2 {
    domens_count::clean();
    domens_count::process('');
    domens_count::process('test@domen1bad');
    domens_count::process('test@@@@domen1bad');
    domens_count::process('test-ttt.ttt@-^%^domen.bad');
}

sub _result_set_2 {
    return "INVALID:\t3\n";
}

ok(
    eval {
        _process_set_2();
        domens_count::print_result();
    } eq _result_set_2(),
    'Result return right text for set 2'
);

sub _process_set_3 {
    domens_count::clean();
}

sub _result_set_3 {
    return "";
}

ok(
    eval {
        _process_set_3();
        domens_count::print_result();
    } eq _result_set_3(),
    'Result return right text for set 3'
);

done_testing();
