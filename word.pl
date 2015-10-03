#!env perl
use Lingua::Stem::Snowball;
    my $stemmer = Lingua::Stem::Snowball->new(
        lang     => 'ru',
        encoding => 'UTF-8',
    );

my ($first,$second) = (file2hash($ARGV[0]),file2hash($ARGV[1]));
sub file2hash{
    my $file=shift;
    open $IN, '<:encoding(utf-8)',$file;
    binmode STDOUT, ":utf8";
    my %hash;

    while (<$IN>) {
        @words = split /[\s,.\!;:]/;
        foreach (@words) {
            $token= $stemmer->stem($_);
            $hash{lc $token}.=$_ . ',';
        }
    }

    return \%hash;
}

foreach ( keys %$first) {
    print "$_  ( $$first{$_} ;$$second{$_}) \n" if (length($_)>2) &&  ( exists $$second{$_} ) ;
}
