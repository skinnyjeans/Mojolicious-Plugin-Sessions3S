#! perl
use strict;
use warnings;

use Test::More;
use Test::Mojo;

use Mojolicious::Lite;

get '/hello' => sub {
    my $self = shift;
    $self->render( text => 'saying hello' );
};

my $t = Test::Mojo->new();

$t->get_ok('/hello');

done_testing();
