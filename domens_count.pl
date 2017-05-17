#!/usr/bin/perl

use Modern::Perl;

require 'libs/domen_from_email.pm';
require 'libs/domens_count.pm';

while (<STDIN>) {
    domens_count::process($_);
}

print domens_count::print_result();
