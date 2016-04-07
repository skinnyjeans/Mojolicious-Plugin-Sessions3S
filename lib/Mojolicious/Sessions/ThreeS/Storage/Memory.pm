package Mojolicious::Sessions::ThreeS::Storage::Memory;

use Mojo::Base qw/Mojolicious::Sessions::ThreeS::Storage/;

my $_SESSION_STORE = {};

sub get_session{
    my ($self, $session_id) = @_;
    return $_SESSION_STORE->{$session_id};
}

sub store_session{
    my ($self, $session_id, $session) = @_;
    $_SESSION_STORE->{$session_id} = $session;
}

sub remove_session_id{
    my ($self, $session_id) = @_;
    delete $_SESSION_STORE->{$session_id};
}

1;
