#!/usr/bin/perl
use Modern::Perl;

use Test::More;

require_ok('libs/domen_from_email.pm');

ok(
    domen_from_email::get_domen('test1@gooddomain.com') eq 'gooddomain.com',
    'Return good domain for emal "test1@gooddomain.com"',
);
ok(
    domen_from_email::get_domen('test2@g.com') eq 'g.com',
    'Return good domain for emal "test2@g.com"',
);
ok(
    domen_from_email::get_domen('test2@gcom') eq '',
    'Return INVALID result for emal "test2@gcom"',
);
ok(
    domen_from_email::get_domen('test2@@@@g.com') eq '',
    'Return INVALID result for emal "test2@@@@@g.com"',
);
ok(
    domen_from_email::get_domen('') eq '',
    'Return INVALID result for emal empty email: ""',
);

done_testing();
