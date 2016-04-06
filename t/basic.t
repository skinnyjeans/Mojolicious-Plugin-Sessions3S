#! perl
use strict;
use warnings;

use Test::More;
use Test::Mojo;

use Mojolicious::Lite;

plugin Sessions3S => {};

get '/hello' => sub {
    my ($self) = @_;
    $self->session( said_hello => 'yup' );
    $self->render( text => 'saying hello' );
};

get '/haveISaidHello' => sub{
    my ($self) = @_;
    $self->render( text => $self->session('said_hello') ? 'yes' : 'nope' );
};

my $t = Test::Mojo->new();

$t->get_ok('/haveISaidHello')->content_like( qr/nope/ );
$t->get_ok('/hello');

# use DDP;
# p $t->tx->res->headers;

$t->get_ok('/haveISaidHello')->content_like( qr/yes/ );

done_testing();
