package Koha::Plugin::Se::Ub::Gu::BuildQueryExample;

use base qw(Koha::Plugins::Base);

## Here we set our plugin version
our $VERSION = 0.01;

## Here is our metadata, some keys are required, some are optional
our $metadata = {
    name   => 'Build Query Example Plugin',
    author => 'Stefan Berndtsson',
    description => 'Example of query altering the query before parsing.',
    date_authored   => '2017-09-08',
    date_updated    => '2017-09-08',
    minimum_version => '17.05',
    maximum_version => undef,
    version         => $VERSION,
};

## This is the minimum code required for a plugin's 'new' method
## More can be added, but none should be removed
sub new {
    my ( $class, $args ) = @_;

    ## We need to add our metadata here so our base class can access it
    $args->{'metadata'} = $metadata;
    $args->{'metadata'}->{'class'} = $class;

    ## Here, we call the 'new' method for our base class
    ## This runs some additional magic and checking
    ## and returns our actual $self
    my $self = $class->SUPER::new($args);

    return $self;
}

# For reference
sub tool {
    my ($self, $args) = @_;
}


sub build_query_before {
    my ($self, $args) = @_;
    my $query = $args->{'operands'};
    my @query = @$query;
    use Data::Dumper;

    foreach my $querypart (@query) {
        $querypart =~ s/^Provider:/publisher:/;
    }

    $args->{'operands'} = \@query;
    
    return $args;
}


sub install {
    my ($self, $args) = @_;
    return 1;
}

sub uninstall {
    my ($self, $args) = @_;
    return 1;
}

1;
