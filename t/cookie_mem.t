#! perl
use strict;
use warnings;

use Test::More;
use Test::Mojo;

use Mojolicious::Lite;

use Mojolicious::Sessions::ThreeS::Storage::Memory;
use Mojolicious::Sessions::ThreeS::State::Cookie;

plugin Sessions3S => { storage => Mojolicious::Sessions::ThreeS::Storage::Memory->new(),
                       state => Mojolicious::Sessions::ThreeS::State::Cookie->new(),
                   };

app->sessions()->cookie_name( 'saussage' );

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
ok( ! $t->tx->res->every_cookie('saussage')->[0] , "Ok no cookie yet");

$t->get_ok('/hello');

# use DDP;
# p $t->tx->res->headers();

is( $t->tx->res->every_cookie('saussage')->[0]->name() , 'saussage' , "Cookie is set with the right name" );

$t->get_ok('/haveISaidHello')->content_like( qr/yes/ );

done_testing();
