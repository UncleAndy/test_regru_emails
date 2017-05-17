package domens_count;

use Modern::Perl;

my $result = {};
my $invalid = 0;

sub clean {
    $result = {};
    $invalid = 0;
}

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
            $result->{ $domen }++;
        }
    }
}

# Выводим результат с сортировкой доменов по количеству
sub print_result {
    my $result_str = '';

    foreach my $domen ( sort { $result->{$b} <=> $result->{$a} } keys %{$result} ) {
        $result_str .= $domen.":\t".$result->{ $domen }."\n";
    };

    $result_str .=  "INVALID:\t".$invalid."\n" if $invalid > 0;

    return $result_str;
}

1;
