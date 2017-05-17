package domens_count;

use Modern::Perl;

my $result = {};
my $invalid = 0;

# Обработка email, анализ домена и увеличение счетчиков
sub process {
    my $email = shift;

    # Убираем концевые пробелы
    $email =~ s/^\s|\s$//;

    # Если email пустой (пустая строка в файле) - делаем возврат без увеличения счетчика INVALID
    if ( defined( $email ) && ( $email ne '' ) ) {
        my $domen = domen_from_email::get_domen( $email );
        if ( $domen eq '' ) {
            $invalid++;
        }
        else {
            _inc_domen($domen);
        }
    }
}

sub print_result {
    # Выводим с сортировкой доменов
    foreach my $domen ( sort { $result->{$b} <=> $result->{$a} } keys %{$result} ) {
        print $domen, ": ", $result->{ $domen }, "\n";
    };

    print "INVALID: ", $invalid, "\n";
}

sub _inc_domen {
    my $domen = shift;

    if ( defined( $result->{ $domen } ) ) {
        $result->{ $domen }++;
    }
    else {
        $result->{ $domen } = 1;
    };
}

1;