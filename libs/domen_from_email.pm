package domen_from_email;

use Modern::Perl;

use Email::Valid;

# Возвращает домен email или пустую строку если email не корректный
sub get_domen {
    my $email = shift;

    return '' if !Email::Valid->address( $email );

    my ( $name, $domain ) = split( '@', $email );

    return( $domain );
}

1;