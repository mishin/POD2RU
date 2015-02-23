package POD2::RU;

use strict;
use 5.008_005;
use utf8;
use warnings;
use base 'Exporter';
use base 'POD2::Base';

our $VERSION = '5.18.0.1.15';

our @EXPORT = qw(print_pod print_pods);

# Versions list
sub pod_info {
    {
        perl        => '5.18.0.1',
        perlintro   => '5.18.0.1',
        perlrun     => '5.18.0.1',
        a2p         => '5.18.0.1',
        perlbook    => '5.18.0.1',
        perldoc     => '5.18.0.1',
        perlpragma  => '5.18.0.1',
        perlstyle   => '5.18.0.1',
        perlcheat   => '5.18.0.1',
        perlnewmod  => '5.18.0.1',
        perlrequick => '5.18.0.1',
        perlreref   => '5.18.0.1',
        perlunicode   => '5.18.0.1',
        perlretut   => '5.18.0.1',
        perlreguts   => '5.18.0.1',
        perlrecharclass   => '5.18.0.1',
        perlrebackslash   => '5.18.0.1',
        perlreapi   => '5.18.0.1',
        perlre   => '5.18.0.1',
        perlsecret   => '5.18.0.1',
        perlreapi   => '5.18.0.1',
    };
}

# String for perldoc with -L switch
sub search_perlfunc_re {
    return 'Список функций Perl';
}

# Print information about a pod file
sub print_pod {
    my $self = shift;
    prepare_encoding_console();
    my @args = @_ ? @_ : @ARGV;

    unless ( ref $self ) {
        if ( defined $self ) {
            if ( $self ne __PACKAGE__ ) {
                unshift @args, $self;
                $self = __PACKAGE__;
            }
        }
        else {
            $self = __PACKAGE__;
        }
    }

    my $pods = $self->pod_info;

    while (@args) {
        ( my $pod = lc( shift @args ) ) =~ s/\.pod$//;
        if ( exists $pods->{$pod} ) {
            print
"\t'$pod' переведены на русский Perl $pods->{$pod}\n";
        }
        else {
            print "\t'$pod' еще не переведены\n";
        }
    }
}

# Print list of translated pods
sub print_pods {
    my $self = @_ ? shift : __PACKAGE__;
    prepare_encoding_console();
    $self->SUPER::print_pods;
}

sub prepare_encoding_console {
    use Encode::Locale qw(decode_argv);
    if (-t) {
        binmode( STDIN,  ":encoding(console_in)" );
        binmode( STDOUT, ":encoding(console_out)" );
        binmode( STDERR, ":encoding(console_out)" );
    }
    Encode::Locale::decode_argv();
}


1;
__END__

=encoding utf-8

=head1 NAME

POD2::RU - Perl Документация по-русски

=head1 SYNOPSIS

  $ perldoc POD2::RU::<название_pod>

  $ perl -MPOD2::RU -e print_pods
  $ perl -MPOD2::RU -e print_pod <название_pod1> [<название_pod2> ...]

  use POD2::RU;
  print_pods();
  print_pod('pod_foo', 'pod_baz');

  use POD2::RU;
  my $pod2 = POD2::RU->new();
  $pod2->print_pods();
  $pod2->print_pod('perlfunc');
                                                                                         
=head1 DESCRIPTION

Модуль POD2::RU содержит перевод Perl-документации на русский. Домашняя страница проекта ─ L<https://github.com/mishin/perldoc-ru>. 

После установки пакета, вы можете использовать следующую команду, чтобы получить документацию:

  $ perldoc POD2::RU::<название_pod>

Начиная с Pod::Perldoc версии 3.14 можно использовать следующий синтаксис:

  $ perldoc -L RU <название_pod>
  $ perldoc -L RU -f <функция>
  $ perldoc -L RU -q <регулярное выражение для FAQ>

Модификатор  C<-L> определяет код языка перевода. Если пакет C<< POD2::<код_языка> >> не существует, то модификатор игнорируется.

Для ленивых можно добавить псевдоним (alias):

  perldoc-ru="perldoc -L RU"

для того, чтобы не писать модификатор  C<-L> каждый раз:

  $ perldoc-ru perlre
  $ perldoc-ru -f map

Начиная с  F<Pod::Perldoc> версии 3.15 вы можете использовать переменную среды PERLDOC_POD2. Если эта переменная установлена в '1', то perldoc осуществляет поиск pod документации на языке, указанном в переменной LC_ALL, LANG или LC_LANG. Или же вы можете установить значение "ru", означающее вывод документации на русском языке. Например,

       export PERLDOC_POD2="ru"
       perldoc perl

=head1 API

Пакет экспортирует следующие функции:

=over 4

=item * C<new>

Была добавлена для совместимости с C<perldoc> Perl 5.10.1.
L<Pod::Perldoc> использует ее для возврата имени пакета перевода.

=item * C<pod_dirs>

Была добавлена для совместимости с C<perldoc> Perl 5.10.1.
L<Pod::Perldoc> использует ее для определения, где искать переведенные файлы.

=item * C<print_pods>

Выводит все переведенные части и оригинальную версию Perl.

=item * C<print_pod>

Выводит на экран оригинальнуя версию Perl для всех частей, переданых в качестве аргументов.

=item * C<search_perlfunc_re>

C<< perldoc -f function >> использует возвращаемое значение этой функции (как regexp), чтобы пропустить введение и найти список функций.

=back

=head1 ПОЖЕРТВОВАНИЕ

Проект перевода документации Perl требует постоянных усилий, что доступно только для сильных духов и альтруистов.
Авторы не просят, но ни не отвергают помощь в виде денег, книг, сыра и продуктов из свинины (можно хамон;) ), или даже поездки в Полинезию для снижения утомления и сохранения боевого духа команды. Мы приглашаем всех.



=head1 ОШИБКИ

Информацию об ошибках и пожелания можно оставить на странице
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=POD2-RU> или
отправить на e-mail C<bug-pod2-ru at rt.cpan.org>, C<mi at ya.ru>.

=head1 ПОДДЕРЖКА

Для просмотра документации в этом модуле, используйте команду C<perldoc>.

    perldoc POD2::RU


Вы также можете найти информацию о:

=over 4

=item * RT: системы отслеживания ощибок для CPAN

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=POD2-RU>

=item * AnnoCPAN: аннотированная документация CPAN

L<http://annocpan.org/dist/POD2-RU>

=item * Рейтинги CPAN

L<http://cpanratings.perl.org/d/POD2-RU>

=item * Поиск CPAN модулей

L<http://search.cpan.org/dist/POD2-RU/>

=back


=head1 БЛАГОДАРНОСТЬ

Авторы хотели бы выразить свою благодарность команде разработчиков OmegaT, инструмента, который используется для перевода.

Проект OmegaT: L<http://omegat.org/>

Также хотелось бы выразить благодарность автору перевода perl документации на испанский язык 
POD2::ES Enrique Nell за его в помощь в напимании скриптов и вообще основу  взял с этого репозитория.
 
Проект POD2::ES: L<https://github.com/zipf/perldoc-es>

Благодарность Yusuke Kawasaki за совет разместить весь проект на github
на вопрос о японской документации он ответил:
They (JPRP people) uses sourceforge and its CVS. 

L<http://sourceforge.jp/cvs/view/perldocjp/docs/modules/>

They are using a traditional mailing list and sourceforge's bug tracking system. In my opinion, github would be a much better way to manage those things at the moment. github was not exist when they started the project.

=head1 AUTHOR

Nikolay Mishin E<lt>mi@ya.ruE<gt>

=head1 АВТОРЫ

=over

=item * Николай Мишин  C<< <mishin@cpan.org> >>
=item * Анатолий Шарифулин  C<< <sharifulin@gmail.com> >>
=item * Алексей Суриков C<< <KSURi> >>
=item * Михаил Любимов  C<< <mikhail.lyubimov> >>
=item * Дмитрий Константинов  C<< <Dim_K> >>
=item * Евгений Баранов  C<< <Baranov> >>
=item * Антон Николаев C<< <me@lelf.lu> >>
=item * Динар Жамалиев C<< <zhdinar> >>
=item * Валерий Кравчук C<< <valera@openxs.kiev.ua> >>

=back

=head1 ПРОЕКТ

Домашняя страница L<https://github.com/mishin/perldoc-ru>.

=head1 COPYRIGHT

Copyright 2015 - Nikolay Mishin

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<POD2::ES>, L<POD2::PT_BR>, L<POD2::IT>, L<POD2::FR>, L<POD2::LT>.

=cut
